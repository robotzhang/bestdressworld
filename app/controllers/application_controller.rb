#coding=utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  def homepage
    render :template => 'homepage'
  end

  def admin
    redirect_to admin_products_url
  end

  # 登录验证
  def authenticated(options)
    default ={
        :role => '',
        :alert => '请先登陆'
    }
    options = default.merge(options)
    if  current_user.nil? || (!options[:role].empty? && current_user.role != options[:role])
      redirect_to login_url, :alert => options[:alert]
      return false
    end
    true
  end

  private
  def current_user
    @current_user ||= session[:user] if session[:user]
    @current_user ||= User.find_by_auth_token!(cookies[:remember_token]) if cookies[:remember_token]
  end

  def signed_in?
    !current_user.nil?
  end

  helper_method :current_user, :signed_in?
end
