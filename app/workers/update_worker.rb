class UpdateWorker
  include Sidekiq::Worker

  def perform(name, count)
    feed_urls = Feed.all.map(&:feed_url)
    feeds = Feedzirra::Feed.fetch_and_parse(feed_urls)

    feeds.each do |feed|
      feed_url = feed[0]
      entries = feed[1].entries
      feed_id = Feed.where(feed_url: feed_url).first.id
      Entry.add_entries(entries, feed_id)
    end

  end

end
