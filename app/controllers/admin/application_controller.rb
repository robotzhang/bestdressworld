#coding=utf-8
class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter do |controller|
    controller.authenticated({:role => ['admin', 'editor'], :alert=>'不具备的权限'})
  end
  authorize_resource
end
