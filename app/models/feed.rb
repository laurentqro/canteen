class Feed < ActiveRecord::Base

  attr_accessible :etag, :last_modified, :publisher_url, :title, :url, :feed_url
  has_many :entries, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  def self.parse_fail?
    if (self == 0 || self == 404 || self == 408)
    end
  end

  def auto_subscribe(current_user)
    if current_user.is_subscribed?(self.id)
      redirect_to Feed.find(self.id)
    else
      @subscription = Subscription.new
      @subscription.user_id = current_user.id
      @subscription.feed_id = self.id
      @subscription.save
    end
  end

end
