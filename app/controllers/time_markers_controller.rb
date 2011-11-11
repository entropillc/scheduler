class TimeMarkersController < ApplicationController
  # GET /time_markers
  # GET /time_markers.json
  def index
    @time_markers = TimeMarker.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @time_markers }
    end
  end

  # GET /time_markers/1
  # GET /time_markers/1.json
  def show
    @time_marker = TimeMarker.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @time_marker }
    end
  end

  # GET /time_markers/new
  # GET /time_markers/new.json
  def new
    @time_marker = TimeMarker.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @time_marker }
    end
  end

  # GET /time_markers/1/edit
  def edit
    @time_marker = TimeMarker.find(params[:id])
  end

  # POST /time_markers
  # POST /time_markers.json
  def create
    @time_marker = TimeMarker.new(params[:time_marker])

    respond_to do |format|
      if @time_marker.save
        format.html { redirect_to @time_marker, notice: 'Time marker was successfully created.' }
        format.json { render :json => @time_marker, status: :created, location: @time_marker }
      else
        format.html { render action: "new" }
        format.json { render :json => @time_marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_markers/1
  # PUT /time_markers/1.json
  def update
    @time_marker = TimeMarker.find(params[:id])

    respond_to do |format|
      if @time_marker.update_attributes(params[:time_marker])
        format.html { redirect_to @time_marker, notice: 'Time marker was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render :json => @time_marker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_markers/1
  # DELETE /time_markers/1.json
  def destroy
    @time_marker = TimeMarker.find(params[:id])
    @time_marker.destroy

    respond_to do |format|
      format.html { redirect_to time_markers_url }
      format.json { head :ok }
    end
  end
end
