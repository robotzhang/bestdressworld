class Admin::AmazonController < ApplicationController
  before_filter do |controller|
    controller.authenticated({:role => 'admin', :alert=>'不具备的权限'})
  end
  layout 'admin'
  def index
    keywords = params[:keywords]
    @items = []
    unless keywords.blank?
      @res = AmazonAPI.new.search(keywords, {:item_page => (params[:page] || 1)})
      @items = Kaminari.paginate_array(@res.items, total_count: @res.total_results).page(params[:page]).per(10)
    end
    #@products = @res.items.map { |item| Product.to_product(item) } unless @res.blank?
  end
end
