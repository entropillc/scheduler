class Event < ActiveRecord::Base
  
  belongs_to :room
  has_many :time_markers
  
  attr_accessible :customer, :event_date, :notes, :room_id
end
