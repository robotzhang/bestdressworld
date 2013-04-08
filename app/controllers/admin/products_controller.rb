class Admin::ProductsController < ApplicationController
  layout 'admin'
  def index
    @products = Product.order(:id).page(params[:page])
  end

  def amazon
    sku = params[:sku] || 'B000YEIAO0'
    Amazon::Ecs.options = {
        :associate_tag => 'bestdressworld-20',
        :AWS_access_key_id => 'AKIAIRZLCIDBLLOW7W3A',
        :AWS_secret_key => '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'
    }
    @product = Amazon::Ecs.item_lookup(sku, {})
  end
end
