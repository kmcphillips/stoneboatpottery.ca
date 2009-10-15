class Subcategory < ActiveRecord::Base
  has_one :image, :as => :imageable
  belongs_to :category
  
  validates_presence_of :category, :name
  validates_uniqueness_of :permalink
  
  attr_protected :id
  attr_readonly :permalink
  
  named_scope :all_active, :conditions => ["active = ?", true]
  
  include Permalink
  before_save :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end
end
