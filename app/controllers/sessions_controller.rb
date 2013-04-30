class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      cookies.permanent[:remember_token] = user.remember_token
      session[:user] = user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.error = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user] = nil
    cookies.delete(:remember_token)
    redirect_to root_path
  end
end
