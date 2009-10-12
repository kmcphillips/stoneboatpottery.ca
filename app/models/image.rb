class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  
  validates_presence_of :path, :imageable
  validates_uniqueness_of :path
  
  attr_protected :id
end
