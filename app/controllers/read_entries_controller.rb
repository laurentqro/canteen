class ReadEntriesController < ApplicationController
  load_and_authorize_resource
  # GET /read_entries
  # GET /read_entries.json
  def index
    @read_entries = User.find(current_user).read_entries

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @read_entries }
    end
  end

  # GET /read_entries/1
  # GET /read_entries/1.json
  def show
    @read_entry = ReadEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @read_entry }
    end
  end

  # GET /read_entries/new
  # GET /read_entries/new.json
  def new
    @read_entry = ReadEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @read_entry }
    end
  end

  # GET /read_entries/1/edit
  def edit
    @read_entry = ReadEntry.find(params[:id])
  end

  # POST /read_entries
  # POST /read_entries.json
  def create
    @read_entry = ReadEntry.new(params[:read_entry])

    respond_to do |format|
      if @read_entry.save
        format.html { redirect_to @read_entry, notice: 'Read entry was successfully created.' }
        format.json { render json: @read_entry, status: :created, location: @read_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @read_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /read_entries/1
  # PUT /read_entries/1.json
  def update
    @read_entry = ReadEntry.find(params[:id])

    respond_to do |format|
      if @read_entry.update_attributes(params[:read_entry])
        format.html { redirect_to @read_entry, notice: 'Read entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @read_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /read_entries/1
  # DELETE /read_entries/1.json
  def destroy
    @read_entry = ReadEntry.find(params[:id])
    @read_entry.destroy

    respond_to do |format|
      format.html { redirect_to read_entries_url }
      format.json { head :no_content }
    end
  end
end
