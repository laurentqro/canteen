class Entry < ActiveRecord::Base
  attr_accessible :author, :content, :feed_id, :image, :published_on, :summary, :title, :url, :gu_id

  belongs_to :feed
  has_many :bookmarks, dependent: :destroy
  has_many :read_entries, dependent: :destroy
  has_many :users, through: :bookmarks
  has_many :users, through: :read_entries



  def self.update_from_feed(feed_url, feed_id)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries, feed_id)
  end

  def self.update_all_feeds
    UpdateWorker.perform_async('update_all_feeds', 25)
  end

  def self.add_entries(entries, feed_id)
    entries.each do |entry|
      if entry.published.nil?
        entry.published = Time.now.to_s
      end
      unless exists? gu_id: entry.url
        create!(
          feed_id: feed_id,
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
