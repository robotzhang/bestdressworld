class ApplicationController < ActionController::Base
  protect_from_forgery
  def homepage
    render :template => 'homepage'
  end

  def admin
    redirect_to admin_products_url
  end
end
