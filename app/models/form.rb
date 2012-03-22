class Form < ActiveRecord::Base
  belongs_to :subcategory

  has_many :images, :as => :imageable, :dependent => :destroy do
    def primary
      first(:conditions => {:primary => true})
    end
  end
  
  validates_presence_of :subcategory, :name, :description
  validates_numericality_of :retail_price, :wholesale_price, :allow_nil => true, :greater_than_or_equal_to => 0
  validate :retail_price_must_be_more_than_wholesale_price
  
  attr_protected :id

  # xss_terminate :except => [:permalink]

  delegate :category, :to => :subcategory

  acts_as_permalink :from => :name

  scope :active, where(["forms.active = ?", true]).order("name ASC")
  scope :inactive, where(["forms.active = ?", false]).order("name ASC")
  date_scopes

  def inherited_active?
    self.active? && self.subcategory.inherited_active?
  end
  
  def deactivate!
    self.update_attribute(:active, false)
  end

protected
  
  def retail_price_must_be_more_than_wholesale_price
    errors.add(:retail_price, "must be greater than the wholesale price") if wholesale_price && retail_price && wholesale_price > retail_price
  end
end
