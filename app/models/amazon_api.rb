class AmazonAPI
  def initialize
    Amazon::Ecs.options = {
        :associate_tag => 'bestdressworld-20', #required when using this version, can be anything (not verified by Amazon
        :AWS_access_key_id => 'AKIAIRZLCIDBLLOW7W3A',
        :AWS_secret_key => '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',
        :response_group => 'Images,ItemAttributes,Offers,VariationSummary,EditorialReview,Reviews,SalesRank',
        :item_page => 1
    }
  end

  # 搜索产品
  def search(keywords, opts = nil)
    opts_default = {:search_index => 'Apparel', :sort => 'salesrank'}
    opts = opts.blank? ? opts_default : opts_default.merge(opts)
    Amazon::Ecs.item_search(keywords, opts)
  end

  # 获取产品详细信息
  def get(asin, opts={:MerchantId => 'All'})
    Amazon::Ecs.item_lookup(asin, opts).first_item
  end

  # 获取图片
  def self.images(item, size='LargeImage')
    images = []
    arrs = item.get_elements('ImageSets/ImageSet/' + size)
    return images if arrs.blank?
    arrs.each_with_index do |arr, index|
      image = Image.new
      image.url = arr.get('URL')
      image.width = arr.get('Width')
      image.height = arr.get('Height')
      image.order = index + 1
      images << image
    end

    images
  end

  # 价格的优先级Offers > PriceList > VariationSummary
  def self.get_price(item)
    price = {
        :currency => 'USD',
        :price => 0,
        :sale_price => 0
    }
    # Offers
    price.merge!(self.format_price(item.get_elements('Offers/Offer/OfferListing/Price')))
    save = self.format_price(item.get_elements('Offers/Offer/OfferListing/AmountSaved'))
    price[:sale_price] = price[:price] + save[:price]

    # ItemAttributes/ListPrice
    if price[:price] == 0
      price.merge!(self.format_price(item.get_elements('ItemAttributes/ListPrice')))
    end

    # VariationSummary
    if price[:price] == 0
      price.merge!(self.format_price(item.get_elements('VariationSummary/HighestPrice')))
      sale = self.format_price(item.get_elements('VariationSummary/LowestSalePrice'))
      price[:sale_price] = sale[:price]
      if price[:sale_price] == 0
        lowest = item.get_elements('VariationSummary/LowestPrice')
        price[:sale_price] = lowest[:price]
      end
    end

    price
  end

  private
  def self.format_price(item)
    price = {
        :price => 0,
        :currency => 'USD'
    }
    return price if item.blank?
    price[:price] = item[0].get('FormattedPrice').gsub(/[^\d.]/, '').to_f
    price[:currency] = item[0].get('CurrencyCode')

    price
  end
end