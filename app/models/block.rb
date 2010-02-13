class Block < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy
  
  validates_uniqueness_of :label
  
  attr_protected :id
  attr_readonly :label

  xss_terminate :except => [:label, :section_path]

  date_scopes

  def label_display
    label.humanize
  end
  
end
