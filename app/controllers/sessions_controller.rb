class SessionsController < ApplicationController
  def new

  end

  def create
    unless request.env['omniauth.auth'].blank?
      user = User.find_or_create_from_auth_hash(request.env['omniauth.auth'])
      session[:user] = user
      return redirect_to root_url, :notice => "Logged in!"
    end

    user = User.find_by_email(params[:session][:email].downcase) if user.blank?
    if user && user.authenticate(params[:session][:password])
      cookies.permanent[:remember_token] = user.remember_token if params[:session][:remember_token]
      session[:user] = user
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    session[:user] = nil
    cookies.delete(:remember_token)
    redirect_to root_path
  end
end
