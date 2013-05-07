#coding=utf-8
class Admin::CategoriesController < ApplicationController
  before_filter do |controller|
    controller.authenticated({:role => 'admin', :alert=>'不具备的权限'})
  end
  layout 'admin'
  def index
    @categories = Category.where(:parent_id => 0).includes(:children).all
  end

  def new
    @category = Category.new(:parent_id => (params[:parent_id] || 0))
    respond_to do |format|
      format.html {render :template => 'admin/categories/new'}
      format.js { j render :layout => false, :template => 'admin/categories/new' }
    end
  end

  def create
    @category = Category.new(params[:category])
    #@category.save ? redirect_to(:action => :index) : render(:template => 'admin/categories/new')
    respond_to do |format|
      if @category.save
        format.html { redirect_to(:action => :index) }
        format.js
      else
        format.html { render action: "new" }
        format.js
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
    respond_to do |format|
      format.html {render :template => 'admin/categories/edit'}
      format.js { j render :layout => false, :template => 'admin/categories/edit' }
    end
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

  def create_for_product
    @product = Product.find(params[:product_id])
    @categories = Category.tree
    if request.post?
      cps = []
      params[:category].each do |category_id|
        cps << {:product_id => params[:product_id], :category_id => category_id}
      end
      @entities = CategoriesProduct.create(cps)
    end
  end
end
