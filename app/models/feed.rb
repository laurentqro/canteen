class Feed < ActiveRecord::Base
  attr_accessible :last_updated, :publisher_url, :title, :url
end
