#coding=utf-8
class OptionsProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :option_id, :scope => :product_id, :message => "%{value} 已经添加"
end
