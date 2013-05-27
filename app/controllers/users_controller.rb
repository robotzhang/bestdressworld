class UsersController < ApplicationController
  layout "user"
  before_filter :find_user, :except => [:new, :create]
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.role = 'brand' unless params[:brand].blank?
    if @user.save
      session[:user] = @user
      redirect_to root_url, :notice => "Signed up!"
    else
      render 'new'
    end
  end

  def show

  end

  def likes

  end

  def brands

  end

  def shares

  end

  protected
  def find_user
    @user = User.find_by_username(params[:id])
    render_404 if @user.nil?
  end
end
