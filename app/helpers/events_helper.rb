module EventsHelper
  
  def has_marker(number, markers)
    markers.each do |marker|
      return false if marker.id.eql?(number)
    end
    return true
  end
  
  def has_time (value)
    times = [ "12:30 am", "1:00 am", "1:30 am", "2:00 am", "2:30 am", "3:00 am", "3:30 am", "4:00 am", "4:30 am", "5:00 am", "5:30 am",
      "6:00 am", "6:30 am", "7:00 am", "7:30 am", "8:00 am", "8:30 am", "9:00 am", "9:30 am", "10:00 am", "10:30 am", "11:00 am",
      "11:30 am", "12:00 pm", "12:30 pm", "1:00 pm", "1:30 pm", "2:00 pm", "2:30 pm", "3:00 pm", "3:30 pm", "4:00 pm", "4:30 pm", "5:00 pm", "5:30 pm",
      "6:00 pm", "6:30 pm", "7:00 pm", "7:30 pm", "8:00 pm" ]
    
    times[value]
    
  end
  
end
