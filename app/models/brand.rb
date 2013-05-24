class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true, :uniqueness => true
  validates :url_key, :presence => true, :uniqueness => true
  validates :introduce, :presence => true, :length => {:maximum => 2000}

  belongs_to :user

  before_validation do
    name = self.name.gsub(/\W/, "")
    self.url_key = name if self.url_key.blank? && name
  end
end
