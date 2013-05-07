#coding=utf-8
class CategoriesProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :category_id, :scope => :product_id, :message => "分类 %{value} 已经添加"
end
