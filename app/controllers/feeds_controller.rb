class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  def index
    @feed = Feed.new
    if params[:q]
      q = params[:q]

      @feeds = Feed.search(title_cont: q).result(distinct: true)
      @entries = Entry.search(title_cont: q).result(distinct: true)
      @users = User.search(last_name_cont: q).result(distinct: true)
    else
      @feeds = Feed.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])
    Entry.update_from_feed(@feed.feed_url, @feed.id)

    @related_feeds = @feed.list_related_feeds(current_user)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.json
  def new
    @feed = Feed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.json
  def create
    Feedzirra::Feed.add_common_feed_element 'image'
    parsed_feed = Feedzirra::Feed.fetch_and_parse(params[:feed][:url])
    feed = Feed.new
    if Feed.parse_fail?(parsed_feed)
      redirect_to root_path, notice: 'Invalid URL.'
    else
      if Feed.exists?(feed_url: parsed_feed.feed_url)
        feed = Feed.find(Feed.where("feed_url = '#{parsed_feed.feed_url}'")[0].id)
        current_user.auto_subscribe(feed)
        redirect_to feed
      else
        feed.title = parsed_feed.title
        feed.gu_id = parsed_feed.etag
        feed.feed_url = parsed_feed.feed_url
        feed.image = parsed_feed.image
        feed.last_updated = parsed_feed.last_modified
        feed.save
        current_user.auto_subscribe(feed)
        redirect_to root_path
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end

  def subscribe
    @feed = Feed.find(params[:id])
    if current_user.is_subscribed?(@feed.id)
      redirect_to Feed.find(params[:id])
    else
      @subscription = Subscription.new
      @subscription.user_id = current_user.id
      @subscription.feed_id = params[:id]
      @subscription.save
      redirect_to Feed.find(params[:id])
    end
  end



  


end
