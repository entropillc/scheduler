module EventsHelper
  
  def has_marker(number, markers)
    markers.each do |marker|
      return false if marker.id.eql?(number)
    end
    return true
  end
  
end
