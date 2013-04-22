class Admin::AmazonController < ApplicationController
  layout 'admin'
  def index
    keywords = params[:keywords]
    @items = AmazonAPI.search(keywords) unless keywords.blank?
  end
end
