module EventCalendar
  class Railtie < Rails::Engine
    initializer :after_initialize do
      if defined?(ActionController::Base)
        ActionController::Base.helper EventCalendar::CalendarHelper
      end
    end
  end
end