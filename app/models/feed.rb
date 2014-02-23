class Feed < ActiveRecord::Base
  attr_accessible :last_updated, :publisher_url, :title, :url
  has_many :entries, dependent: :destroy
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
