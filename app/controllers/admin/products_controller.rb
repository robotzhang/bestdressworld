class Admin::ProductsController < ApplicationController
  layout 'admin'
  def index
    @products = Product.order(:id).page(params[:page])
  end

  def amazon
    asin = params[:asin] || 'B000YEIAO0'
    @product = Product.get_amazon(asin)
  end
end
