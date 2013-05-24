class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true, :uniqueness => true
  validates :introduce, :presence => true, :length => {:maximum => 2000}

  belongs_to :user
end
