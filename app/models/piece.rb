class Piece < ActiveRecord::Base
  has_many :images, :as => :imageable do
    def primary
      first(:conditions => {:primary => true})
    end
    def primary_first
      all(:order => "`primary` DESC, updated_at DESC")
    end
  end

  validates_presence_of :name, :description, :permalink
  validate :price_if_for_sale  

  attr_protected :id
  attr_readonly :permalink

  include Permalink
  before_validation_on_create :update_permalink

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end

  def price_if_for_sale
    self.errors.add(:price, "must be a positive number if the piece is for sale") if self.for_sale? && (!self.price || self.price <= 0)
  end
end
