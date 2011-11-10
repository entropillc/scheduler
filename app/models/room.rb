class Room < ActiveRecord::Base
  has_many :events
  has_many :time_markers
end
