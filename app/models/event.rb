class Event < ActiveRecord::Base
  
  belongs_to :room
  belongs_to :customer
  has_many :time_markers, :dependent => :destroy
  
  attr_accessible :customer_name, :customer_id, :event_date, :notes, :room_id
  
  before_save :set_customer_name
  
  def set_customer_name
    c = Customer.find(self.customer_id)
    self.customer_name = c.full_name
  end
  
  def add_time_markers(markers)
    logger.debug markers
    
    markers.each do |marker|
      if TimeMarker.existing?(marker, room_id, event_date)
        return false
      end
    end
    
    markers.each do |marker|
      new_marker = self.time_markers.build
      new_marker.marker = marker
      new_marker.room_id = self.room_id
      new_marker.marker_date = self.event_date
      
      time_markers << new_marker
    end
  end
  
end
