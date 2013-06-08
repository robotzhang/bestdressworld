#coding=utf-8
class Product < ActiveRecord::Base
  #attr_accessible :asin, :sku, :name, :from_url, :buy_url
  acts_as_taggable

  scope :desc, order("products.updated_at DESC")
  default_scope order("products.ranking DESC, products.updated_at DESC, products.hits DESC")

  attr_protected :user_id, :updater_id

  validates_uniqueness_of :asin, :message => "%{value} has already been shared"

  has_many :images, :as => :imageable, :order => '`order` ASC'
  has_and_belongs_to_many :categories
  after_destroy {categories.clear}
  has_and_belongs_to_many :options
  after_destroy {options.clear}
  has_one :description, :dependent => :destroy
  has_one :discount, :dependent => :destroy
  belongs_to :user

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :description, :discount

  before_save do
    self.discount = nil if self.discount.blank? || self.discount.sale_price <= 0
    self.updater_id = self.user_id if !self.updater_id && self.user_id
    self.discount.price = self.price if self.discount && self.discount.price.blank?
  end

  after_save do
    ranking = self.count_ranking
    self.update_column(:ranking, ranking)
  end

  # 批量抓取
  def self.create_with_amazon(asins=[], user)
    result = []
    asins.each do |asin|
      begin
        product = self.get_amazon(asin.strip)
        product.user_id = user.id
        product.updater_id = user.id
        result << (product.save ? {success: true, asin: asin, message: "share #{asin} success"} : {success: false, asin: asin, message: product.errors.full_messages})
      rescue
        result << {success: false, asin: asin, message: "get data form amazon fail"}
      end
    end

    result
  end

  def self.get_amazon(asin)
    AmazonAPI.new.get(asin)
    self.to_product(AmazonAPI.new.get(asin))
  end

  # 解析amazon返回的xml对象成系统product对象
  def self.to_product(item)
    product = Product.new
    product.asin = item.get('ASIN')
    product.sku = item.get('ItemAttributes/SKU')
    product.name = sanitize(CGI.unescapeHTML(item.get('ItemAttributes/Title'))).squeeze(" ")
    product.name = product.name[1..(product.name.size-2)]
    product.sales_rank = item.get('SalesRank')
    product.publisher = item.get('ItemAttributes/Publisher')
    product.studio = item.get('ItemAttributes/Studio')
    product.from_url = item.get('DetailPageURL')
    product.buy_url = 'http://www.amazon.com/gp/product/' + product.asin + '?tag=' + 'bestdressworld-20'
    product.from_site = 'amazon'
    product.seo_url = product.name.gsub(/[^\w\s]/, ' ').squeeze(" ").strip.gsub(' ', '-').downcase unless product.name.blank?
    # get price
    price = AmazonAPI.get_price(item)
    product.price = price[:price]
    product.currency = price[:currency]
    # set discount
    if !price[:sale_price].blank?
      product.discount = Discount.new(
          :price => product.price,
          :sale_price => price[:sale_price]
      )
    end
    # get description
    product.description = Description.new.get_from_amazon(item)
    # get images
    product.images = AmazonAPI.images(item)

    product
  end

  def currency_symbol
    case self.currency
      when 'USD'
        '$'
      else
        '$'
    end
  end

  def next
    self.class.where("id > ?", self.id).order("id asc").first
  end

  def previous
    self.class.where("id < ?", self.id).order("id desc").first
  end

  def count_ranking
    max_hits = Product.maximum(:hits)
    # 按照sales_rank分档次 , >1w: , 5k-1w: , 3k-5k, ,
    # updated_at: 1天内 100%，1周内 80%，1月内 60%，1季度 50%，半年 30%，1年 20%，大于1年 10%
    # hits:
    # 权重的配比是 hits: 50%, sale_rank: 20%, updated_at: 20%, created_at: 10%
    ranking = 0
    r = case self.sales_rank
          when nil then 0
          when 10000..20000 then 0.2
          when 5000..10000 then 0.3
          when 1000..5000 then 0.5
          when 700..1000 then 0.7
          when 500..700 then 0.8
          when 200..500 then 0.9
          when 0..200 then 1
          else 0.1
        end
    ranking += r*20

    ranking += date_ranking(self.updated_at)*30
    ranking += date_ranking(self.created_at)*10

    ranking_hits = self.hits.to_f / max_hits
    ranking_hits = 0.1 if ranking_hits < 0.1
    ranking += (ranking_hits * 40).to_i
  end

  private
  def date_ranking(date)
    days = (Time.now.to_s.to_date - date.to_date).to_i
    case days
      when 0 then 1
      when 1 then 0.9
      when 1..7 then 0.8
      when 7..30 then 0.6
      when 30..90 then 0.5
      when 90..180 then 0.3
      when 180..365 then 0.2
      else 0.1
    end
  end
end
