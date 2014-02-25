class Feed < ActiveRecord::Base

  attr_accessible :etag, :last_modified, :publisher_url, :title, :url, :feed_url
  has_many :entries, dependent: :destroy
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def self.parse_fail?
    if (self == 0 || self == 404 || self == 408)
    end
  end


end
