require 'date'
module WelcomeHelper
  
  def create_base_date(month, year)
    Date.new(year, month, 1)
  end
  
  def get_previous_month(month, year)
    (create_base_date(month, year) - 1.month).month
  end
  
  def get_next_month(month, year)
    create_base_date(month, year).next_month.month
  end
  
  def get_next_query_year(month, year)
    create_base_date(month, year).next_month.year
  end
  
  def get_previous_query_year(month, year)
    (create_base_date(month, year) - 1.month).year
  end
  
  
  def number_of_squares(month, year)
    squares_needed = (first_day_of_month(month, year)-1) + days_in_month(month, year)
    
    logger.info "square needed: " + squares_needed.to_s
    
    squares_needed.modulo(7).eql?(0) ? squares_needed : squares_needed + (7 - squares_needed.modulo(7))
  end
  
  def first_day_of_month(month, year)
    Date.new(year, month, 1).beginning_of_month.wday+1  
  end
  
  def days_in_month(month, year)
    (Date.new(year, 12, 31) << (12-month)).day
  end
  
  def list_events(month, day, year)
    current_day = Date.new(year, month, day)
    html = ""
    @events.each do |event|
      if event.event_date.eql?(current_day)
        party_type = event.party_type.eql?(1) ? "Basic " : "Deluxe "
        html += content_tag(:div, party_type + 'Events: ' + event.event_count.to_s)
      end
    end
    content_tag(:div, raw(html))
  end
  
end
