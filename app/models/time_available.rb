class TimeAvailable < ActiveRecord::Base
  has_many :time_markers
  
  
  default_scope order("display_order desc")
  
end
