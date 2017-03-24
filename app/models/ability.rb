class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new

    can %i(read by_tag), Post
    can :read, Blog

    if user.persisted?
      can :crud, Post, user_id: user.id
      cannot %i(create update destroy), Article
      can %i(like dislike), Post
      can(:follow, User) { |author| author != user }
    end

    if user.has_role?(User::Roles::EDITOR)
      can :enter, :admin
      can :crud, Article
    end

    if user.has_role?(User::Roles::ADMIN)
      can :enter, :admin
    end
  end
end
