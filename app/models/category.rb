class Category < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :subcategories
  
  named_scope :all_active, :conditions => ["active = ?", true]
  
  def active_subcategories
    self.subcategories.find(:all, :conditions => ["active = ?", true])
  end
end
