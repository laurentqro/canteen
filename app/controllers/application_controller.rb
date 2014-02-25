class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_feeds, :setup_feed_instance_variable

  def setup_feed_instance_variable
    @feed = Feed.new
  end

  private
  def setup_feeds
    @feeds = Feed.all
  end
 
  
end
