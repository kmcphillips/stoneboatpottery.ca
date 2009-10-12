class Subcategory < ActiveRecord::Base
  has_one :image, :as => :imageable
  belongs_to :category
  
  validates_presence_of :category
  
  named_scope :all_active, :conditions => ["active = ?", true]
  
  include Permalink
  before_save :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.title)
  end
end
