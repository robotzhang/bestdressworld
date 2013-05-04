module ApplicationHelper
  def nav_active(controller=nil, action=nil)
    arr = controller.is_a?(Array) ? controller : [controller]
    return ' class=active' if arr.include?(params[:controller]) || (action == 'homepage' && params[:controller] == 'application')
    ''
  end

  def display_errors(object)
    return '' if object.blank? || object.errors.blank?
    render "admin/common/errors", :errors => object.errors
  end
end
