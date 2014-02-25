class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_feeds, :setup_feed, :setup_subscription, :setup_subscriptions, :setup_tags

  private

  def setup_feed
    @feed = Feed.new
  end

  def setup_subscription
    @subscription = Subscription.new
  end

  def setup_subscriptions
    if current_user
      @subscriptions = User.find(current_user.id).subscriptions
    else
      @subscriptions = Feed.all
    end
  end

  def setup_feeds
    @feeds = Feed.all
  end

  def setup_tags
    @tags = Subscription.where("user_id = '#{current_user.id}'").tag_counts_on(:tags).order('count desc').limit(20)
  end

end
