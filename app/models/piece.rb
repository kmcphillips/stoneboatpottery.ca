class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable, :dependent => :destroy do
    def primary
      first(:conditions => {:primary => true})
    end
  end

  acts_as_permalink :from => :name

  validates_presence_of :name, :description
  validate :price_if_for_sale  

  attr_protected :id

  xss_terminate :except => [:permalink, :type]

  named_scope :active, :conditions => ["active = ?", true], :order => "name ASC"  
  named_scope :inactive, :conditions => ["active = ?", false], :order => "name ASC"
  date_scopes

protected

  def price_if_for_sale
    self.errors.add(:price, "must be a positive number if the piece is for sale") if self.for_sale? && (!self.price || self.price <= 0)
  end
end
