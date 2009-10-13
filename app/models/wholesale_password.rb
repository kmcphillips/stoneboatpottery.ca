class WholesalePassword < ActiveRecord::Base
  validates_presence_of :password
  validates_uniqueness_of :password
  
  attr_protected :id
end
