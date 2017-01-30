class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable, :dependent => :destroy do
    def primary
      where(:primary => true).first
    end
  end

  acts_as_permalink :from => :name

  validates_presence_of :name, :description
  validate :price_if_for_sale

  scope :active, ->{ where(["active = ?", true]) }
  scope :inactive, ->{ where(["active = ?", false]) }
  scope :sorted, ->{ order("name DESC") }
  date_scopes

  protected

  def price_if_for_sale
    self.errors.add(:price, "must be a positive number if the piece is for sale") if self.for_sale? && (!self.price || self.price <= 0)
  end
end
