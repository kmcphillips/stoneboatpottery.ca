class Block < ActiveRecord::Base
  has_one :image, :as => :imageable
  
  validates_uniqueness_of :label
  validates_presence_of :body
  
  attr_protected :id, :label
  
end
