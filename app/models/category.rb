class Category < ActiveRecord::Base
  has_one :image, :as => :imageable, :dependent => :destroy
  has_many :subcategories
  has_many :forms, :through => :subcategories

  acts_as_permalink :from => :name

  validates_presence_of :name

  scope :active, ->{ where(["categories.active = ?", true]).order("name ASC") }
  scope :inactive, ->{ where(["categories.active = ?", false]).order("name ASC") }
  scope :sorted, ->{ order("name DESC") }
  date_scopes

  before_save :deactivate_children

  def active_subcategories
    self.subcategories.where(["active = ?", true])
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
    self.subcategories.map(&:deactivate!) if self.active_changed? && ! self.active?
  end
end
