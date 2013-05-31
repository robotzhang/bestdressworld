#coding=utf-8
class UserDecorator < Draper::Decorator
  delegate_all
  # 头像地址
  def image
    return object.image if !object.image.blank?
    return gravatar if object.email
    ""
  end

  def nickname
    return object.nickname if object.nickname
    object.identities.first.name
  end

  # 参数说明：s - 大小 d - 默认图片,default -自定义的默认头像
  # http://www.gravatar.com/emails/修改
  def gravatar
    hash = Digest::MD5.hexdigest(object.email.downcase)
    "http://www.gravatar.com/avatar/#{hash}.png?s=80&d=mm"
  end
end
