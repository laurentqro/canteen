class Entry < ActiveRecord::Base
  attr_accessible :author, :content, :feed_id, :image, :published_on, :summary, :title, :url
  belongs_to :feed
end
