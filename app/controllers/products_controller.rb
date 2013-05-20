class ProductsController < ApplicationController
  def index
    @products = Product.order("id DESC").includes([:images,:discount]).page(params[:page]).per(10).decorate
    respond_to do |format|
      format.html
      format.js {render :template => 'products/waterfall' }
    end
  end

  def show
    @product = Product.find_by_seo_url(params[:seo_url]).decorate
  end
end
