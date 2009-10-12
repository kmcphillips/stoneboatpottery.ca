class Category < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :subcategories
  
  named_scope :all_active, :conditions => ["active = ?", true]
  
  include Permalink
  before_save :update_permalink
  
  def active_subcategories
    self.subcategories.find(:all, :conditions => ["active = ?", true])
  end

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end
end
