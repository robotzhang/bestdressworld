#coding=utf-8
class Admin::OptionsController < Admin::ApplicationController
  def index
    return redirect_to(:action => :index, :group => Option.groups[0][1]) if params[:group].blank?
    @options = Option.find_all_by_group(params[:group])
  end

  def new
    @option = Option.new(:group => params[:group])
    render :template => "admin/options/form"
  end

  def create
    @option = Option.new(params[:option])
    @option.save ? redirect_to(:action => :index, :group => @option.group) : render(:template => "admin/options/form")
  end

  def edit
    @option = Option.find(params[:id])
    render :template => "admin/options/form"
  end

  def update
    @option = Option.find(params[:id])
    @option.update_attributes(params[:option]) ? redirect_to(:action => :index, :group => @option.group) : render(:template => 'admin/options/form')
  end

  def destroy
    @option = Option.find(params[:id])
    @option.destroy
    redirect_to :action => :index
  end

  def create_for_product
    @product = Product.find(params[:product_id])
    if request.post?
      ops = []
      params[:option].each do |option_id|
        ops << {:product_id => params[:product_id], :option_id => option_id}
      end
      @entities = OptionsProduct.create(ops)
    end
  end
end
