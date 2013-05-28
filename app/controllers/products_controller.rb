class ProductsController < ApplicationController
  load_and_authorize_resource

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

  def create
    asin = params[:asin]
    flash[:alert] = "Amazon asin can't be blank" if asin.blank?
    flash[:alert] = "Amazon asin: #{asin} has already been shared" if !Product.find_by_asin(asin).blank?
    redirect_to params[:ret_url]
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
