class Admin::AmazonController < ApplicationController
  layout 'admin'
  def index
    keywords = params[:keywords]
    @products = []
    @res = AmazonAPI.new.search(keywords) unless keywords.blank?
    #@products = @res.items.map { |item| Product.to_product(item) } unless @res.blank?
  end
end
