#coding=utf-8
class Admin::ProductsController < ApplicationController
  before_filter do |controller|
    controller.authenticated({:role => 'admin', :alert=>'不具备的权限'})
  end
  layout 'admin'
  def index
    @products = Product.order("id DESC").includes([:discount, :images]).page(params[:page]).per(10)
  end

  def amazon
    asin = params[:asin]
    return redirect_to({:action => :index}, :flash => { :error => 'asin: '+asin+' 已经抓取！' }) unless Product.find_by_asin(asin).blank?
    return redirect_to({:action => :index}, :flash => { :error => '要抓取的asin不能为空！' }) if asin.blank?
    @product = Product.get_amazon(asin)
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      params[:ret_url].blank? ? redirect_to(:action => :index) : redirect_to(params[:ret_url], :asin => @product.asin)
    else
      render(:template => 'admin/products/_form')
    end
  end

  def edit

  end

  def update

  end
end
