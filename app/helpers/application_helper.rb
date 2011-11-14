module ApplicationHelper
  
  def time_available_values
    if @time_availables
      string = '['
      @time_availables.each do |time_available|
        string += "{ id: " + time_available.id.to_s + ", time: '" + time_available.name + "'}"
        unless time_available.id.eql?(@time_availables.last.id)
          string += ','
        end
      end
      string += ']'
    end
  end
  
end
