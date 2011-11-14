require 'active_record/fixtures'

# Load Fixtures
ActiveRecord::Fixtures.create_fixtures(File.join(File.dirname(__FILE__), 'seed'), 'rooms')
ActiveRecord::Fixtures.create_fixtures(File.join(File.dirname(__FILE__), 'seed'), 'time_availables')