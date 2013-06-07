#coding=utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to login_url(:ret_url => request.url), :alert => exception.message
  end

  def homepage
    @hottest = Product.includes([:images]).limit(6).decorate
    @latest = Product.unscoped.order("updated_at DESC").includes([:images]).limit(6).decorate
    render :template => 'homepage_v1'
  end

  def admin
    redirect_to admin_products_url
  end

  # 登录验证
  def authenticated(options)
    default ={
        :role => [],
        :alert => '请先登陆'
    }
    options = default.merge(options)
    if  current_user.nil? || (!options[:role].empty? &&  !options[:role].include?(current_user.role))
      redirect_to login_url, :alert => options[:alert]
      return false
    end
    true
  end

  private
  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
    @current_user ||= User.find_by_remember_token!(cookies[:remember_token]) if cookies[:remember_token]
    return @current_user.decorate if @current_user
    @current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? user : user.id
  end

  def signed_in?
    !current_user.nil?
  end

  helper_method :current_user, :signed_in?
end
