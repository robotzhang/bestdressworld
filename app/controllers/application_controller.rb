class ApplicationController < ActionController::Base
  protect_from_forgery
  def homepage
    render :template => 'homepage'
  end
end
