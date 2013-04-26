#coding=utf-8
class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"
  has_and_belongs_to_many :products
  belongs_to :parent, :class_name => "Category"

  validates_presence_of :name, :message => '分类名称不能为空'
  validates_uniqueness_of :name, :message => '%{value} 分类名称不能重复'
  validates_presence_of :url_key, :message => '必须指定分类在url中显示的字符串'

  def self.tree
    nodes = Hash.new
    self.order('parent_id ASC').all.each do |category|
      nodes.each do |parent, children|
        if (parent.id == category.parent_id)
          nodes[parent] << { category => [] }
          break
        end
      end
      nodes[category] = []
    end

    nodes
  end

  before_validation {
    self.name = self.name.strip unless self.name.blank?
    if self.url_key.blank? && !self.name.blank?
      self.url_key = self.name.downcase.gsub(/[^\w\s]/, ' ').gsub(' ', '-')
    end
  }
end
