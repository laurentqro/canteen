    # t.string   "title"
    # t.string   "url"
    # t.string   "publisher_url"
    # t.datetime "last_updated"
    # t.datetime "created_at",    :null => false
    # t.datetime "updated_at",    :null => false
    # t.string   "gu_id"
    # t.string   "image"
    # t.string   "feed_url"

# Feed.destroy_all

#     feeds = [
#               { title: "Reddit",          url: "http://www.reddit.com",       feed_url: "http://www.reddit.com/.rss" },
#               { title: "xkcd",            url: "http://xkcd.com",             feed_url: "http://xkcd.com/atom.xml" },
#               { title: "Techcrunch",      url: "http://techcrunch.com",       feed_url: "http://techcrunch.com/feed/" },
#               { title: "The Verge",       url: "http://www.theverge.com",     feed_url: "http://www.theverge.com/rss/frontpage" },
#               { title: "Mashable",        url: "http://www.mashable.com",     feed_url: "http://feeds.mashable.com/Mashable" },
#               { title: "Engadget",        url: "http://www.engadget.com",     feed_url: "http://www.engadget.com/rss.xml" },
#               { title: "ReadWriteWeb",    url: "http://www.readwrite.com",    feed_url: "http://readwrite.com/main/feed/articles.xml" },
#               { title: "The Next Web",    url: "http://www.thenextweb.com",   feed_url: "http://thenextweb.com/feed/" },
#               { title: "Gizmodo",         url: "http://www.gizmodo.com",      feed_url: "http://feeds.feedburner.com/uk/gizmodo" },
#               { title: "Fubiz",           url: "http://www.fubiz.net",        feed_url: "http://www.fubiz.net/feed/" }
#             ]

# feeds.each do |feed|
#   Feed.create! feed_url: feed[:feed_url], title: feed[:title], url: feed[:url]
# end
