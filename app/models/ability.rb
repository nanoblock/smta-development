class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role? :admin
        can :manage, :all
    elsif user.has_role? :editor
        can :manage, :all
    elsif user.has_role? :developer
        can :manage, :all
    elsif user.has_role? :user
        can :read, Image
    end

  end
end
