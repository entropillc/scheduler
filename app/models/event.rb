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
      
      values = marker.chars.to_a
      
      if TimeMarker.existing?(values[2], values[0], event_date)
        return false
      end
    end
    
    markers.each do |marker|
      values = marker.chars.to_a
      new_marker = self.time_markers.build
      new_marker.time_available_id = values[2]
      new_marker.room_id = values[0]
      new_marker.marker_date = self.event_date
      
      time_markers << new_marker
    end
  end
  
end
