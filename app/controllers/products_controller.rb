#coding=utf-8
class ProductsController < ApplicationController
  load_and_authorize_resource

  def index
    @products = Product.order("id DESC").includes([:images,:discount]).page(params[:page]).per(16).decorate
    respond_to do |format|
      format.html
      format.js {render :template => 'products/waterfall' }
    end
  end

  def show
    @product = Product.find_by_seo_url(params[:seo_url]).decorate
  end

  def create
    asin = params[:asin]
    flash[:alert] = "Amazon asin can't be blank" if asin.blank?
    if flash[:alert].blank?
      result = Product.create_with_amazon(asin.split(","), current_user)
      flash[:alert] = result
    end

    flash[:asin] = asin
    redirect_to params[:ret_url]
  end

  # 通过app id和app secret key进行站外抓取amazon数据
  def api_create
    @res = []

    user = User.find_by_username(params[:app_id])
    if user.nil? || params[:app_secret] != Digest::MD5.hexdigest('Good!23')
      @res << {:success => false, :message => "权限不够"}
    else
      @res = Product.create_with_amazon(params[:asin].split(","), user)
    end

    respond_to do |format|
      format.json {render :json => @res}
      format.xml {render :xml => @res}
    end
  end

  def edit
    @product = Product.find(params[:id]).decorate
  end

  def update
    @product = Product.find(params[:id])
    @product.updater_id = current_user.id
    if @product.update_attributes(params[:product])
      redirect_to (params[:ret_url] || root_url)
    else
      render :action => "edit"
    end
  end
end
