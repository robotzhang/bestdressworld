class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_role?(:admin)
      can :manage, :all
    elsif user.has_role?(:editor)
      can [:create, :read, :update, :amazon], [Product]
      can [:create, :read, :update], [Brand]
      basic_read_only
    else
      cannot :manage, :all
      basic_read_only
    end
  end

  protected
  def basic_read_only
    can :read, :all
  end
end
