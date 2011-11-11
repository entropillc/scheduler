class WelcomeController < ApplicationController
  
  def index
    
    if params[:date]
      @rooms = Room.includes(:time_markers).where("time_markers.marker_date", params[:date])
    else
      @rooms = Room.includes(:time_markers).where("time_markers.marker_date", Time.now.strftime("%m/%d/%Y"))
    end
    
  end
  
end
