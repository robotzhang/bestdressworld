#coding=utf-8
class User < ActiveRecord::Base
  acts_as_tagger

  attr_accessible :username, :email, :password, :password_confirmation # 这个地方很重要,否则前台可以伪造表单的role字段从而提升权限
  attr_protected :role
  has_secure_password

  validates :username, presence: true,
            format: {:with => /\A\w+\z/, :message => 'must contain only these characters: a-zA-Z0-9_'},
            length: { :in => 3..20 },
            uniqueness: {:case_sensitive => false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  has_one :brand
  has_many :identities
  has_many :products

  before_save { |user| user.email = email.downcase unless email.blank? }
  before_save :create_remember_token

  def has_role?(role)
    self.role == role.to_s
  end

  def self.find_or_create_with_omniauth(auth)
    identity = Identity.find_with_omniauth(auth)
    identity = Identity.create_with_omniauth(auth) if identity.blank?
    return identity.user if identity && identity.user
    user = User.new(username: 'sns_' + (identity.id+10086).to_s, nickname: identity.name)
    user.identities = [identity]
    user.save!(:validate => false)
    user
  end

  private
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
