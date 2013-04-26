#coding=utf-8
class CategoriesProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :product_id, :scope => :category_id, :message => "该分类已经添加"
end
