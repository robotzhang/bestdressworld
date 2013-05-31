class Identity < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :user_id, presence: true
  validates :provider, presence: true
  validates :uid, presence: true, :uniqueness => {:scope => :provider}
  belongs_to :user
end
