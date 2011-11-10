class TimeMarker < ActiveRecord::Base
  belongs_to :event
  belongs_to :room
end
