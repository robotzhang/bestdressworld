#coding=utf-8
class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"
  belongs_to :parent, :class_name => "Category"

  validates_presence_of :name, :message => '分类名称不能为空'
  validates_presence_of :url_key, :message => '必须指定分类在url中显示的字符串'

  before_validation {
    if self.url_key.blank? && !self.name.blank?
      self.url_key = self.name.downcase.gsub(/[^\w\s]/, ' ').gsub(' ', '-')
    end
  }
end
