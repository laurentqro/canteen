class Bookmark < ActiveRecord::Base
  attr_accessible :user_id, :entry_id
  belongs_to :user
  belongs_to :entry
end
