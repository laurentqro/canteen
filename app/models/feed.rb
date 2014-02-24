class Feed < ActiveRecord::Base

  attr_accessible :last_modified, :publisher_url, :title, :url, :etag
  has_many :entries, dependent: :destroy
  has_many :subscriptions
  has_many :users, through: :subscriptions

end
