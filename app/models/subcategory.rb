class Subcategory < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy
  has_many :forms
  belongs_to :category

  acts_as_permalink :from => :name
  
  validates_presence_of :category, :name
  
  attr_protected :id

  # xss_terminate :except => [:permalink]

  before_save :deactivate_children

  scope :active, where(["subcategories.active = ?", true]).order("name ASC")
  scope :inactive, where(["subcategories.active = ?", false]).order("name ASC")
  date_scopes

  def inherited_active?
    self.active? && self.category.inherited_active?
  end

  def deactivate!
    if self.active?
      update_attribute(:active, false)
      self.forms.active.map(&:deactivate!)
    end
  end

protected

  def deactivate_children
    self.forms.active.map(&:deactivate!) if self.active_changed? && ! self.active?
  end
end
