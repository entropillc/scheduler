class Customer < ActiveRecord::Base
  has_many :events
  
  default_scope order('last_name, first_name')
  
  def full_name
    last_name + ', ' + first_name
  end
  
  def list_value
    phone_number.nil? ? full_name : full_name + ' - '+ phone_number 
  end
  
end