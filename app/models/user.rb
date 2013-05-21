#coding=utf-8
class User < ActiveRecord::Base
  attr_accessible :nickname, :email, :password, :password_confirmation # 这个地方很重要,否则前台可以伪造表单的role字段从而提升权限
  attr_protected :role
  has_secure_password

  validates :nickname, presence: true,
            format: {:with => /\A\w+\z/, :message => 'must contain only these characters: a-zA-Z0-9_'},
            length: { :in => 3..20 },
            uniqueness: {:case_sensitive => false}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save { |user| user.email = email.downcase unless email.blank? }
  before_save :create_remember_token

  def has_role?(role)
    self.role == role.to_s
  end

  # 通过第三方查找或者创建用户
  def self.find_or_create_from_auth_hash(auth)
    user = User.new({:sns_uid => auth.uid, :sns_provider => auth.provider, :nickname => auth.info.nickname, :image => auth.info.image})
    user.nickname = auth.info.name if user.nickname.blank?
    user.email = auth.info.email if auth.info.email
    user_db = User.where({:sns_uid => user.sns_uid, :sns_provider => user.sns_provider}).first
    return user_db unless user_db.blank?
    user.save!(:validate => false) # 不验证保存
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
