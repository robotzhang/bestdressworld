class ProductsController < ApplicationController
  def index
    @products = Product.page(params[:page])
  end

  def show
    @product = Product.find_by_seo_url(params[:seo_url])
  end
end
