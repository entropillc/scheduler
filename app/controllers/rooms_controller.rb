class RoomsController < ApplicationController
  respond_to :json
  
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all

    render json: @rooms.to_json(
      :except => [ :created_at, :updated_at ],
      :include => {
        :time_markers => {
          :only => [:marker, :event => {
            :only => [:customer, :notes]
          }]
        }
      }
    ) 
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @room = Room.find(params[:id])

    render json: @room.to_json(
      :except => [ :created_at, :updated_at ],
      :include => {
        :time_markers => {
          :only => [:marker, :event => {
            :only => [:customer, :notes]
          }]
        }
      }
    )
  end

  # GET /rooms/new
  # GET /rooms/new.json
  def new
    @room = Room.new

    render json: @room 
  end

  # GET /rooms/1/edit
  def edit
    @room = Room.find(params[:id])
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(params[:room])

    if @room.save
      render json: @room, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.json
  def update
    @room = Room.find(params[:id])

    if @room.update_attributes(params[:room])
      head :ok
    else
      render json: @room.errors, status: :unprocessable_entity 
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room = Room.find(params[:id])
    @room.destroy

    head :ok 
  end
end
