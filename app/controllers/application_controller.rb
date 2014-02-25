class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_feeds, :setup_feed_instance_variable, :setup_tags

  def setup_tags
    @tags = Subscription.where("user_id = '#{current_user.id}'").tag_counts_on(:tags).order('count desc').limit(20)
  end

  def setup_feed_instance_variable
    @feed = Feed.new
  end

  private
  def setup_feeds
    @feeds = Feed.all
  end
 
  
end
