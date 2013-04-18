module ApplicationHelper
  def current_user
    session[:user]
  end

  def nav_active(controller=nil, action=nil)
    return ' class=active' if params[:controller] == controller || (action == 'homepage' && params[:controller] == 'application')
    ''
  end
end
