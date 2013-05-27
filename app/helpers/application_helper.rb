#coding=utf-8
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

  def display_alert
    return '' if flash[:alert].blank?
    "<p class='alert'>#{flash[:alert]}<button onclick='$(this).parent('p').remove();' class='close'>×</button></p>".html_safe
  end
end
