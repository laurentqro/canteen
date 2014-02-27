class Ability
  include CanCan::Ability

  
  def initialize(user)
    user ||= User.new
    if user.role? :admin
      can :manage, :all

    elsif user.role? :user
      can :read, :all

      can :create, Subscription
      can :manage, Subscription 

      can :create, Bookmark
      can :manage, Bookmark do |bookmark|
      bookmark.user == user
      end

      can :create, Feed
      can :create, Entry

      can :subscribe, Feed
      can :bookmark, Entry
      can :mark_as_read, Entry

      can :tagged, Subscription

    else
      can :index, Feed 
      can :create, User


    end
  end
end
