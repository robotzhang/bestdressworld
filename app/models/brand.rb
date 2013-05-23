class Brand < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :name, :presence => true, :uniqueness => true

  belongs_to :user
end
