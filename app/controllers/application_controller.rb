class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_feeds, :setup_feed, :setup_subscriptions

  

  def setup_feed
    @feed = Feed.new
  end


  def setup_subscriptions
    @subscriptions = User.find(current_user.id).subscriptions
  end

  private
  def setup_feeds
    @feeds = Feed.all
  end


end
