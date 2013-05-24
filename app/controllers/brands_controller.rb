class BrandsController < ApplicationController
  authorize_resource
  def index
    @brands = Brand.order("id DESC").page(params[:page]).per(20)
  end

  def show
    @brand = Brand.find_by_url_key(params[:url_key])
    @brand = Brand.find(params[:url_key]) if @brand.blank?
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(params[:brand])
    @brand.save ? redirect_to(:action => :index) : render(:action => :new)
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    @brand.update_attributes(params[:brand]) ? redirect_to(:action => :index) : render(:action => :edit)
  end
end
