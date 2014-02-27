class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :bio, :avatar, :email, :role, :password, :password_confirmation, :remember_me, :avatar_cache, :remove_avatar

  has_many :subscriptions, dependent: :destroy
  has_many :read_entries, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :feeds, through: :subscriptions
  has_many :entries, through: :bookmarks
  has_many :entries, through: :read_entries


  def is_subscribed?(feed_id)
    user_id = self.id
    if Subscription.exists?(user_id: user_id, feed_id: feed_id)
      return true
    end
  end

  def has_bookmarked?(entry_id)
    user_id = self.id
    if Bookmark.exists?(user_id: user_id, entry_id: entry_id)
      return true
    end
  end

  def has_read?(entry_id)
    user_id = self.id
    if ReadEntry.exists?(user_id: user_id, entry_id: entry_id)
      return true
    end
  end

  def auto_subscribe(feed)
    if self.is_subscribed?(feed.id) != true
      @subscription = Subscription.new
      @subscription.user_id = self.id
      @subscription.feed_id = feed.id
      @subscription.save
    end
  end

end
