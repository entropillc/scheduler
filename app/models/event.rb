class Event < ActiveRecord::Base
  
  belongs_to :room
  belongs_to :customer
  has_many :time_markers, :dependent => :destroy
  
  attr_accessible :customer_name, :customer_id, :event_date, :notes, :room_id, :party_type
  
  before_save :set_customer_name
  
  def set_customer_name
    c = Customer.find(self.customer_id)
    self.customer_name = c.full_name
  end
  
  def add_time_markers(markers)
    logger.debug markers
    
    markers.each do |marker|
      logger.debug marker
      logger.debug marker[0]
      if TimeMarker.existing?(marker[2], marker[0], event_date)
        return false
      end
    end
    
    markers.each do |marker|
      new_marker = self.time_markers.build
      new_marker.time_available_id = marker[2]
      new_marker.room_id = marker[0]
      new_marker.marker_date = self.event_date
      
      time_markers << new_marker
    end
  end
  
end
