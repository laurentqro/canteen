class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  def index
    @feeds = Feed.all
    @feed = Feed.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    binding.pry
    @feed = Feed.find(params[:id])
    Entry.update_from_feed(@feed.url, @feed.id)

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
    if (parsed_feed == 0 || parsed_feed == 404 || parsed_feed == 408)
      redirect_to root, notice: 'Invalid URL.'
    else
      feed.title = parsed_feed.title
      feed.gu_id = parsed_feed.etag
      feed.url = parsed_feed.feed_url
      feed.image = parsed_feed.image
      feed.last_updated = parsed_feed.last_modified

      if Feed.exists?(url: parsed_feed.feed_url)
        redirect_to Feed.find(Feed.where("url = '#{parsed_feed.feed_url}'")[0].id)
      else
        feed.save
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
end
