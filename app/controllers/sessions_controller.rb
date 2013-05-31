class SessionsController < ApplicationController
  def new

  end

  def create
    unless request.env['omniauth.auth'].blank?
      return create_with_omniauth
    end

    user = User.find_by_email(params[:session][:email].downcase) if user.blank?
    if user && user.authenticate(params[:session][:password])
      cookies.permanent[:remember_token] = user.remember_token if params[:session][:remember_token]
      self.current_user = user
      redirect_to redirect_url, :notice => "Logged in!"
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    self.current_user = nil
    cookies.delete(:remember_token)
    redirect_to redirect_url
  end

  protected
  def redirect_url(url=nil)
    return url if url
    params[:ret_url] || root_path
  end

  def create_with_omniauth
    auth = request.env['omniauth.auth']
    @identity = Identity.find_with_omniauth(auth)
    if @identity.nil? # 说明没有绑定该登录方式
      @identity = Identity.create_with_omniauth(auth)
    end

    if signed_in? # 已登录
      if current_user == @identity.user
        redirect_to redirect_url, notice: "Already linked that account!"
      else
        @identity.user = current_user
        @identity.save()
        redirect_to redirect_url, notice: "Successfully linked that account!"
      end
    else
      self.current_user = User.find_or_create_with_omniauth(auth)
      redirect_to redirect_url, :notice => "Signed in!"
    end
  end
end
