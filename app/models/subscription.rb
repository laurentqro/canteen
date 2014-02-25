class Subscription < ActiveRecord::Base
  attr_accessible :user_id, :feed_id, :tag_list
  belongs_to :user
  belongs_to :feed

  acts_as_taggable_on :tags

 

end
