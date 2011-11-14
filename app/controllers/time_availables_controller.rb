class TimeAvailablesController < ApplicationController
  # GET /time_availalbes
  # GET /time_availalbes.json
  def index
    @time_availalbes = TimeAvailable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @time_availalbes }
    end
  end

  # GET /time_availalbes/1
  # GET /time_availalbes/1.json
  def show
    @time_availalbe = TimeAvailable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @time_availalbe }
    end
  end

  # GET /time_availalbes/new
  # GET /time_availalbes/new.json
  def new
    @time_availalbe = TimeAvailable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @time_availalbe }
    end
  end

  # GET /time_availalbes/1/edit
  def edit
    @time_availalbe = TimeAvailable.find(params[:id])
  end

  # POST /time_availalbes
  # POST /time_availalbes.json
  def create
    @time_availalbe = TimeAvailable.new(params[:time_availalbe])

    respond_to do |format|
      if @time_availalbe.save
        format.html { redirect_to @time_availalbe, :notice => 'Time Available was successfully created.' }
        format.json { render :json => @time_availalbe, :status => :created, :location => @time_availalbe }
      else
        format.html { render :action => "new" }
        format.json { render :json => @time_availalbe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /time_availalbes/1
  # PUT /time_availalbes/1.json
  def update
    @time_availalbe = TimeAvailable.find(params[:id])

    respond_to do |format|
      if @time_availalbe.update_attributes(params[:time_availalbe])
        format.html { redirect_to @time_availalbe, :notice => 'Time Available was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @time_availalbe.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /time_availalbes/1
  # DELETE /time_availalbes/1.json
  def destroy
    @time_availalbe = TimeAvailable.find(params[:id])
    @time_availalbe.destroy

    respond_to do |format|
      format.html { redirect_to time_availalbes_url }
      format.json { head :ok }
    end
  end
end
