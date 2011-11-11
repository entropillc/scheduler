class Customer < ActiveRecord::Base
  has_many :events
  
  default_scope order('last_name, first_name')
  
  def full_name
    last_name + ', ' + first_name
  end
  
end