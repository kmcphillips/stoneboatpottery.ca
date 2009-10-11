class Subcategory < ActiveRecord::Base
  has_one :image, :as => :imageable
  belongs_to :category
  
  validates_presence_of :category
  
  named_scope :all_active, :conditions => ["active = ?", true]
end
