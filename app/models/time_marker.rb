class TimeMarker < ActiveRecord::Base
  belongs_to :event
  belongs_to :room
    
  attr_accessible :marker, :event_id, :room_id, :marker_date
  
  scope :by_date, lambda { |date|
    where("marker_date = ?", date)
  }
  
  def self.existing?(marker, room, date)    
    if find_by_marker_and_room_id_and_marker_date(marker, room, date)
      return true
    else
      return false
    end
  end
  
   def as_json(options={})
     {
       marker: self.marker,
       marker_date: self.marker_date,
       event_id: self.event_id,
       event_name: self.event.customer
     }
   end
  
end
