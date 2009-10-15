class Block < ActiveRecord::Base
  has_one :image, :as => :imageable
  
  validates_uniqueness_of :label
  
  attr_protected :id
  attr_readonly :label
  
  def label_display
    label.humanize
  end
  
end
