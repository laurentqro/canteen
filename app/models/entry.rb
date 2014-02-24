class Entry < ActiveRecord::Base
  attr_accessible :author, :content, :feed_id, :image, :published_on, :summary, :title, :url, :gu_id
  belongs_to :feed

  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
  end

  private

  def self.add_entries(entries)
    entries.each do |entry|
      unless exists? gu_id: entry.id
        create!(
          title: entry.title,
          summary: entry.summary,
          url: entry.url,
          author: entry.author,
          published_on: entry.published,
          content: entry.content,
          gu_id: entry.id
        )
      end
    end
  end

end
