class AmazonAPI
  def initialize
    Amazon::Ecs.options = {
        :associate_tag => 'bestdressworld-20', #required when using this version, can be anything (not verified by Amazon
        :AWS_access_key_id => 'AKIAIRZLCIDBLLOW7W3A',
        :AWS_secret_key => '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'
    }
  end

  def get(asin, opts={:ResponseGroup => 'Images,ItemAttributes,Offers,VariationSummary,EditorialReview,Reviews,SalesRank,VariationImages',
                      :MerchantId => 'All'})
    Amazon::Ecs.item_lookup(asin, opts).first_item
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

    #p price
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