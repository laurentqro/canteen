class ReadEntry < ActiveRecord::Base
  attr_accessible :entry_id, :user_id
  belongs_to :user
  belongs_to :entry
end
