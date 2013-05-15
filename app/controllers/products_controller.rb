class ProductsController < ApplicationController
  def index
    @products = Product.order("id DESC").includes([:images,:discount]).page(params[:page]).per(10)
  end

  def show
    @product = Product.find_by_seo_url(params[:seo_url])
  end
end
