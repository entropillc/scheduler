class Customer < ActiveRecord::Base
  
  default_scope order('last_name, first_name')
  
  def full_name
    first_name + ' ' + last_name
  end
  
end