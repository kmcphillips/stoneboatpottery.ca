class Form < ActiveRecord::Base
  belongs_to :subcategory

  has_many :images, :as => :imageable, :dependent => :destroy do
    def primary
      where(primary: true).first
    end
  end

  validates_presence_of :subcategory, :name, :description
  validates_numericality_of :retail_price, :allow_nil => true, :greater_than_or_equal_to => 0

  delegate :category, :to => :subcategory

  acts_as_permalink :from => :name

  scope :active, ->{ where(["forms.active = ?", true]).order("name ASC") }
  scope :inactive, ->{ where(["forms.active = ?", false]).order("name ASC") }
  date_scopes

  def inherited_active?
    self.active? && self.subcategory.inherited_active?
  end

  def deactivate!
    self.update_attribute(:active, false)
  end

end
