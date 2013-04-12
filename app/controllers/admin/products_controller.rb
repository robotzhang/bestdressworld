#coding=utf-8
class Admin::ProductsController < ApplicationController
  layout 'admin'
  def index
    @products = Product.order(:id).page(params[:page])
  end

  def amazon
    asin = params[:asin]
    return redirect_to({:action => :index}, :flash => { :error => '要抓取的asin不能为空！' }) if asin.blank?
    @product = Product.get_amazon(asin)
  end

  def create
    @product = Product.new(params[:product])
    @product.save ? redirect_to(:action => :index) : render(:template => 'admin/products/_form')
  end

  def edit

  end

  def update

  end
end
