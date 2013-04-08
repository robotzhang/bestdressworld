class Admin::ProductsController < ApplicationController
  layout 'admin'
  def index
    @products = Product.order(:id).page(params[:page])
  end
end
