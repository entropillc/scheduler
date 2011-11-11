class Room < ActiveRecord::Base
  has_many :events
  has_many :time_markers
  
  def as_json(options={})
    opts = {
      :date   => Time.now.strftime("%Y-%m-%d"),
    }.merge options
    
    logger.debug opts[:date]
     
     {
       :name => self.name,
       :time_markers => self.time_markers.by_date(opts[:date])
     }
  end
  
end
