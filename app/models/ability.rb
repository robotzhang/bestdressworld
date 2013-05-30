class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank? # 游客
      cannot :manage, :all
      basic_read_only
    elsif user.has_role?(:admin) # 系统管理员 admin
      can :manage, :all
    elsif user.has_role?(:editor) # 网站编辑 editor
      can [:create, :read, :update, :amazon], [Product]
      can [:create, :read, :update], [Brand]
      basic_read_only
    elsif user.has_role?(:brand) # 品牌用户 brand
      can :create, Brand
      can [:update, :destroy], Brand do |brand|
        brand.user_id == user.id
      end
      basic_user_role(user)
      basic_read_only
    elsif user.has_role?(:user) # 基本用户 user
      basic_user_role(user)
      basic_read_only
    else
      cannot :manage, :all
      basic_read_only
    end
  end

  protected
  def basic_user_role(user)
    can [:update], User do |me|
      me.id == user.id
    end
    can [:create, :update], Product do |product|
      (product.user_id == user.id)
    end
  end
  def basic_read_only
    can :read, :all
  end
end
