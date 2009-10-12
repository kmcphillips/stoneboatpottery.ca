class Link < ActiveRecord::Base
  
  validates_presence_of :url
  validates_uniqueness_of :url
  
  attr_protected :id
end
