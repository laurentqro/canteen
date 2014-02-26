class Feed < ActiveRecord::Base

  attr_accessible :etag, :last_modified, :publisher_url, :title, :url, :feed_url
  has_many :entries, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions

  def self.parse_fail?(feed)
    feed == 0 || feed == 404 || feed == 408
  end

  def list_related_feeds(current_user)
    feeds = []
    self.users.each do |user|
      if user != current_user
        user.subscriptions.map do |subscription|
          if subscription.feed != self
          feeds << subscription.feed
          end
        end
      end
    end
    feeds.uniq
  end

end
