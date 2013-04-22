module ApplicationHelper
  def current_user
    session[:user]
  end

  def nav_active(controller=nil, action=nil)
    arr = controller.is_a?(Array) ? controller : [controller]
    return ' class=active' if arr.include?(params[:controller]) || (action == 'homepage' && params[:controller] == 'application')
    ''
  end
end
