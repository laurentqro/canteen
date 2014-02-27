class EntriesController < ApplicationController
  load_and_authorize_resource
  # GET /entries
  # GET /entries.json
  before_filter :mark_as_read_on_show, only: :show

  def index
    
    @entries = Entry.all
    if current_user
      all_user_entries = User.find_by_id(current_user.id).feeds.map {|feed| feed.entries}.flatten
      unread_entries = all_user_entries.reject {|entry| entry.read_entries.find_by_user_id(current_user.id)}
      
      if params[:read].present? && params[:read] == "true"
        @entries = unread_entries
      else
        @entries = all_user_entries
      end
    else
    @entries = Entry.all 
   end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
    mark_as_read
    @entry = Entry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/new
  # GET /entries/new.json
  def new
    @entry = Entry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @entry }
    end
  end

  # GET /entries/1/edit
  def edit
    @entry = Entry.find(params[:id])
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = Entry.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_url }
      format.json { head :no_content }
    end
  end

  def bookmark
    @entry = Entry.find(params[:id])
    if current_user.has_bookmarked?(@entry.id)
      bookmark = Bookmark.where('user_id = ? AND entry_id = ?', current_user.id, @entry.id)[0]
      bookmark.destroy
      redirect_to @entry.feed
    else  
      @bookmark = Bookmark.new
      @bookmark.user_id = current_user.id
      @bookmark.entry_id = params[:id]
      @bookmark.save
      redirect_to @entry.feed
    end 
  end

  def mark_as_read
    @entry = Entry.find(params[:id])
    if current_user.has_read?(@entry.id)
      read_entry = ReadEntry.where('user_id = ? AND entry_id = ?', current_user.id, @entry.id)[0]
      read_entry.destroy 
      redirect_to @entry.feed
    else  
      @read_entry = ReadEntry.new
      @read_entry.user_id = current_user.id
      @read_entry.entry_id = params[:id]
      @read_entry.save
      redirect_to @entry.feed
    end 
  end
  
  private  
  def mark_as_read_on_show 
  if current_user
    @entry = Entry.find(params[:id])
    if current_user.has_read?(@entry.id) != true
      read_entry = ReadEntry.new
      read_entry.user_id = current_user.id
      read_entry.entry_id = params[:id]
      read_entry.save
    end 
  end
    render 'show'
  end 
  
end
