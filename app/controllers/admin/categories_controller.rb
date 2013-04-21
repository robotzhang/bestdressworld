class Admin::CategoriesController < ApplicationController
  layout 'admin'
  def index
    @categories = Category.where(:parent_id => 0).includes(:children).all
  end

  def new
    @category = Category.new(:parent_id => (params[:parent_id] || 0))
  end

  def create
    @category = Category.new(params[:category])
    @category.save ? redirect_to(:action => :index) : render(:template => 'admin/categories/new')
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:category][:id])
    @category.update_attributes(params[:category]) ? redirect_to(:action => :index) : render(:template => 'admin/categories/edit')
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to :action => :index
  end
end
