class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.has_role?(User::Roles::ADMIN)
      can :manage, :all
    end

  end
end
