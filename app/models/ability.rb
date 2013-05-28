class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role?(:admin) # 系统管理员
      can :manage, :all
    elsif user.has_role?(:editor) # 网站编辑
      can [:create, :read, :update, :amazon], [Product]
      can [:create, :read, :update], [Brand]
      basic_read_only
    elsif user.has_role?(:brand) # 品牌用户
      can :create, Brand
      can [:update, :destroy], Brand do |brand|
        (brand.user_id == user.id)
      end
      basic_read_only
    else # 游客
      cannot :manage, :all
      basic_read_only
    end
  end

  protected
  def basic_read_only
    can :read, :all
  end
end
