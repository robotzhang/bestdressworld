#coding=utf-8
class Option < ActiveRecord::Base
  # attr_accessible :title, :body
  has_and_belongs_to_many :products

  @groups = [
    ['颜色', 'color'], ['材质', 'fabric'], ['下摆', 'silhouette'], ['腰', 'waist'], ['领圈', 'neckline'], ['袖子', 'sleeve length'],
    ['裙脚/裙裾', 'hemline/train'], ['装饰品', 'embellishments']
  ]

  validates_presence_of :group
  validates :group, :inclusion => { :in => @groups.map{|g| g[1]} }
  validates_presence_of :code
  validates_uniqueness_of :code, :scope => :group

  before_create do
    self.code = self.code.strip.downcase
    self.name_en = self.code if self.name_en.blank?
  end

  def self.groups
    @groups
  end

  def self.data
    options = Hash.new
    self.all.each do |op|
      if !options.blank? && options.map{|k, v| k}.include?(op.group)
        options[op.group] << op
        next
      end
      options[op.group] = [op]
    end

    options
  end
end
