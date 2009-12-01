class Category < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :subcategories
  
  validates_uniqueness_of :permalink
  validates_presence_of :name
  
  attr_protected :id
  attr_readonly :permalink
  
  named_scope :active, :conditions => ["active = ?", true], :order => "updated_at DESC"
  
  include Permalink
  before_validation_on_create :update_permalink
  
  before_save :deactivate_children

  def active_subcategories
    self.subcategories.find(:all, :conditions => ["active = ?", true])
  end

  def count_forms
    subcategories.inject(0) { |total, subcategory| total + subcategory.forms.size }
  end

  def list_subcategories
    subcategories.map(&:name).join(", ") || ""
  end

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end

  def deactivate_children
    if self.active_changed? && ! self.active?
      self.subcategories.each do |subcategory|
        subcategory.update_attribute(:active, false) if subcategory.active?
      end
    end
  end
end
