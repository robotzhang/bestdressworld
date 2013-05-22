#coding=utf-8
class Category < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :children, :class_name => "Category", :foreign_key => "parent_id"
  has_and_belongs_to_many :products
  after_destroy {products.clear}
  belongs_to :parent, :class_name => "Category"

  validates_presence_of :code, :message => '分类名称不能为空'
  validates_uniqueness_of :code, :message => '%{value} 分类名称不能重复'
  validates_presence_of :url_key, :message => '必须指定分类在url中显示的字符串'

  def self.tree
    nodes = Hash.new
    self.order('parent_id ASC').all.each do |category|
      is_parent = true
      nodes.each do |parent, children|
        if (parent.id == category.parent_id)
          nodes[parent] << { category => [] }
          is_parent = false
          break
        end
      end
      nodes[category] = [] if is_parent
    end

    nodes
  end

  def name
    name_en
  end

  before_validation {
    self.code = self.code.strip.downcase unless self.code.blank?
    self.name_en = self.code if self.name_en.blank?
    if self.url_key.blank? && !self.name_en.blank?
      self.url_key = self.name_en.downcase.gsub(/[^\w\s]/, ' ').gsub(' ', '-')
    end
  }
end
