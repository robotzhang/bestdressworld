#coding=utf-8
class Product < ActiveRecord::Base
  #attr_accessible :asin, :sku, :name, :from_url, :buy_url
  validates_uniqueness_of :asin, :message => "%{value} 已经入库"
  has_many :images, :as => :imageable, :order => '`order` ASC'
  has_and_belongs_to_many :categories
  has_one :description, :dependent => :destroy
  has_one :discount, :dependent => :destroy

  accepts_nested_attributes_for :images
  accepts_nested_attributes_for :description, :discount

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
    if !price[:sale_price].blank? && price[:sale_price] > 0
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

  def self.colors
    %w(black white red golden ivory wine pink)
  end

  def self.fabrics
    %w(chiffon organza taffeta satin stretch\ satin stretch\ silk-like\ satin lace tulle sequins)
  end
end
