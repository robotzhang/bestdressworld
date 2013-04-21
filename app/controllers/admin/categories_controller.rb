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

  end

  def update

  end
end
