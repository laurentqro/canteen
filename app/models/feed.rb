class Feed < ActiveRecord::Base
  attr_accessible :last_updated, :publisher_url, :title, :url, :gu_id
  has_many :entries

  def fetch_and_parse(url)
    feed = Feedzirra::Feed.fetch_and_parse(url) # => Feedzirra Parser object
    entries = feed.entries # array
    # feed_methods = [:title, :summary, :url, :published]

    # entries.each do |entry|
    #   feed_methods.each do |meth|
    #     entry.send(meth)
    #   end
    # end
  end



end
