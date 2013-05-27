class UsersController < ApplicationController
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
    @user = User.find_by_username(params[:username])
  end
end
