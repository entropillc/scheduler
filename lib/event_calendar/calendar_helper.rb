module EventCalendar
  module CalendarHelper
   
    def calendar(options ={}, &block)
      defaults = {
        :year => (Time.zone || Time).now.year,
        :month => (Time.zone || Time).now.month,
        :abbrev => true,
        :first_day_of_week => 0,
        :show_today => true,
        :show_header => true,
        :month_name_text => (Time.zone || Time).now.strftime("%B %Y"),
        :previous_month_text => nil,
        :next_month_text => nil,
        :event_strips => [],

        # it would be nice to have these in the CSS file
        # but they are needed to perform height calculations
        :width => nil,
        :height => 500,
        :day_names_height => 18,
        :day_nums_height => 18,
        :event_height => 18,
        :event_margin => 1,
        :event_padding_top => 2,

        :use_all_day => false,
        :use_javascript => true,
        :link_to_day_action => false
      }
      options = defaults.merge options

      # make the height calculations
      # tricky since multiple events in a day could force an increase in the set height
      height = options[:day_names_height]
      row_heights = cal_row_heights(options)
      row_heights.each do |row_height|
        height += row_height
      end

      # the first and last days of this calendar month
      if options[:dates].is_a?(Range)
        first = options[:dates].begin
        last = options[:dates].end
      else
        first = Date.civil(options[:year], options[:month], 1)
        last = Date.civil(options[:year], options[:month], -1)
      end

      # Get the names of the days
      day_names = I18n.translate(:'date.day_names')


      # Build the HTML string
      cal = ""

      # outer calendar container
      cal << %(<div class="ec-calendar")
      cal << %(style="width: #{options[:width]}px;") if options[:width]
      cal << %(>)

      # body container (holds day names and the calendar rows)
      cal << %(<div class="ec-body" style="height: #{height}px;">)

      # day names
      cal << %(<table class="ec-day-names" style="height: #{options[:day_names_height]}px;" cellpadding="0" cellspacing="0">)
      cal << %(<tbody><tr>)
      day_names.each do |day_name|
        cal << %(<th class="ec-day-name" title="#{day_name}">#{day_name}</th>)
      end
      cal << %(</tr></tbody></table>)

      # container for all the calendar rows
      cal << %(<div class="ec-rows" style="top: #{options[:day_names_height]}px; )
      cal << %(height: #{height - options[:day_names_height]}px;">)

      # initialize loop variables
      first_day_of_week = beginning_of_week(first, options[:first_day_of_week])
      last_day_of_week = end_of_week(first, options[:first_day_of_week])
      last_day_of_cal = end_of_week(last, options[:first_day_of_week])
      row_num = 0
      top = 0

      # go through a week at a time, until we reach the end of the month
      while(last_day_of_week <= last_day_of_cal)
        cal << %(<div class="ec-row" style="top: #{top}px; height: #{row_heights[row_num]}px;">)
        top += row_heights[row_num]

        # this weeks background table
        cal << %(<table class="ec-row-bg" cellpadding="0" cellspacing="0">)
        cal << %(<tbody><tr>)
        first_day_of_week.upto(first_day_of_week+6) d  o |day|
         today_class = (day == Date.today) ? "ec-today-bg" : ""
         other_month_class = (day < first) || (day > last) ? 'ec-other-month-bg' : ''
         cal << %(<td class="ec-day-bg #{today_class} #{other_month_class}">&nbsp;</td>)
        end
        cal << %(</tr></tbody></table>)

        # calendar row
        cal << %(<table class="ec-row-table" cellpadding="0" cellspacing="0">)
        cal << %(<tbody>)

        # day numbers row
        cal << %(<tr>)
        first_day_of_week.upto(last_day_of_week) do |day|
         cal << %(<td class="ec-day-header )
         cal << %(ec-today-header ) if options[:show_today] and (day == Date.today)
         cal << %(ec-other-month-header ) if (day < first) || (day > last)
         cal << %(ec-weekend-day-header) if weekend?(day)
         cal << %(" style="height: #{options[:day_nums_height]}px;">)
         if options[:link_to_day_action]
           cal << day_link(day.day, day, options[:link_to_day_action])
         else
           cal << %(#{day.day})
         end
         cal << %(</td>)
        end
        cal << %(</tr>)
        cal << %(</tbody></table>)
        cal << %(</tbody></table>)
        cal << %(</div>)

        # increment the calendar row we are on, and the week
        row_num += 1
        first_day_of_week += 7
        last_day_of_week += 7
      end

      cal << %(</div>)
      cal << %(</div>)
      cal << %(</div>) 
   end 
   
   
  end
end