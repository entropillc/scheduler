class WelcomeController < ApplicationController
  
  def index
    if params[:date]
      @rooms = Room.includes(:time_markers).where("time_markers.marker_date", params[:date])
    else
      @rooms = Room.includes(:time_markers).where("time_markers.marker_date", Time.now.strftime("%m/%d/%Y"))
    end
    
    @time_availables = TimeAvailable.all
  end
  
  def calendar
    @calendar_year = params[:year].nil? ? Date.today.year : Integer(params[:year])
    @calendar_month = params[:month].nil? ? Date.today.month : Integer(params[:month])
    
    @events = Event.find_events_in_month(@calendar_month, @calendar_year)
  end
  
end
