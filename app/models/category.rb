class Category < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :subcategories
  
  validates_uniqueness_of :permalink
  validates_presence_of :name
  
  attr_protected :id
  attr_readonly :permalink
  
  named_scope :all_active, :conditions => ["active = ?", true]
  
  include Permalink
  before_validation_on_create :update_permalink
  
  def active_subcategories
    self.subcategories.find(:all, :conditions => ["active = ?", true])
  end

  def count_forms
    subcategories.inject(0) { |total, subcategory| total + subcategory.forms.size }
  end

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end
end
