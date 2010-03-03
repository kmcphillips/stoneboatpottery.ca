class Form < ActiveRecord::Base
  belongs_to :subcategory

  has_many :images, :as => :imageable, :dependent => :destroy do
    def primary
      first(:conditions => {:primary => true})
    end
  end
  
  validates_presence_of :subcategory, :name, :description
  validate :retail_price_must_be_more_than_wholesale_price, :wholesale_price_must_be_valid, :retail_price_must_be_valid
  
  attr_protected :id

  xss_terminate :except => [:permalink]

  delegate :category, :to => :subcategory

  acts_as_permalink :from => :name

  named_scope :active, :conditions => ["forms.active = ?", true], :order => "name ASC"
  named_scope :inactive, :conditions => ["forms.active = ?", false], :order => "name ASC"
  date_scopes

  def inherited_active?
    self.active? && self.subcategory.inherited_active?
  end

protected
  
  def retail_price_must_be_more_than_wholesale_price
    errors.add(:retail_price, "must be greater than the wholesale price") if wholesale_price && retail_price && wholesale_price > retail_price
  end
  
  def wholesale_price_must_be_valid
    errors.add(:wholesale_price, "must be a positive value or blank") if !wholesale_price.blank? && wholesale_price < 0
  end
  
  def retail_price_must_be_valid
    errors.add(:retail_price, "must be a positive value or blank") if !retail_price.blank? && retail_price < 0
  end
end
