class Identity < ActiveRecord::Base
  # attr_accessible :title, :body
  validates :provider, presence: true
  validates :uid, presence: true, :uniqueness => {:scope => :provider}
  belongs_to :user

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_with_omniauth(auth)
    create!(uid: auth['uid'], provider: auth['provider'], image: auth['info']['image'], email: auth['info'][:email], name: auth['info'][:name])
  end
end
