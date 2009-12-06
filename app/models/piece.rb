class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable do
    def primary
      first(:conditions => {:primary => true})
    end
    def primary_first
      all(:order => "`primary` DESC, updated_at DESC")
    end
  end

  acts_as_permalink :from => :name

  named_scope :active, :conditions => ["`active` = ?", true], :order => "updated_at DESC"
  named_scope :inactive, :conditions => ["`active` = ?", false], :order => "updated_at DESC"

  validates_presence_of :name, :description
  validate :price_if_for_sale  

  attr_protected :id

protected

  def price_if_for_sale
    self.errors.add(:price, "must be a positive number if the piece is for sale") if self.for_sale? && (!self.price || self.price <= 0)
  end
end
