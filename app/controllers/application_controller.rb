class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :setup_feeds


  private
  def setup_feeds
    @feeds = Feed.all
  end
 
  
end
