class EventsController < ApplicationController
  respond_to :json
  
  def index
    @events = Event.all
    
    render json: @events
  end

  def show
    @event = Event.find(params[:id])
    
    render json: @event
  end

  def new
    @event = Event.new
    
    render json: @event
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      render json: @event, status: :created, location: @event
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
    
    render json: @event
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      head :ok
    else
      render json: @event.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    
    head :ok 
  end
end
