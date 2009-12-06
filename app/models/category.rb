class Category < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :subcategories

  acts_as_permalink :from => :name
  
  validates_presence_of :name
  
  attr_protected :id
  
  named_scope :active, :conditions => ["active = ?", true], :order => "updated_at DESC"  
  named_scope :inactive, :conditions => ["active = ?", false], :order => "updated_at DESC"
  
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

  def inherited_active?
    self.active?
  end

protected

  def deactivate_children
    if self.active_changed? && ! self.active?
      self.subcategories.each do |subcategory|
        subcategory.update_attribute(:active, false) if subcategory.active?
      end
    end
  end
end
