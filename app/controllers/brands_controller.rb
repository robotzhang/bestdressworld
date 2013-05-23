class BrandsController < ApplicationController
  def index
    @brands = Brand.order("id DESC").page(params[:page]).per(20)
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end
end
