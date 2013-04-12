#coding=utf-8
class Product < ActiveRecord::Base
  #attr_accessible :asin, :sku, :name, :from_url, :buy_url
  validates_uniqueness_of :asin, :message => "%{value} 已经入库"

  def self.get_amazon(asin)
    AmazonAPI.new.get(asin)
    self.to_product(AmazonAPI.new.get(asin))
  end

  # 解析amazon返回的xml对象成系统product对象
  def self.to_product(item)
    product = Product.new
    product.asin = item.get('ASIN')
    product.sku = item.get('ItemAttributes/SKU')
    product.name = item.get('ItemAttributes/Title')
    product.publisher = item.get('ItemAttributes/Publisher')
    product.studio = item.get('ItemAttributes/Studio')
    product.from_url = item.get('DetailPageURL')
    product.buy_url = 'http://www.amazon.com/gp/product/' + product.asin + '?tag=' + 'bestdressworld-20'
    product.from_site = 'amazon'
    product.seo_url = product.name.gsub(/[^\w\s]/, ' ').gsub(' ', '-').downcase unless product.name.blank?
    # get price
    price = AmazonAPI.get_price(item)
    product.price = price[:price]
    product.currency = price[:currency]

    product
  end
end
