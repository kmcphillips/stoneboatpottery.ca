class Block < ActiveRecord::Base
  has_one :image, :as => :imageable
  
  validates_uniqueness_of :label
  
  # TODO: lable should be protected
  attr_protected :id
  
  def label_display
    label.humanize
  end
  
end
