class Subcategory < ActiveRecord::Base
  has_one :image, :as => :imageable
  has_many :forms
  belongs_to :category
  
  validates_presence_of :category, :name
  validates_uniqueness_of :permalink
  
  attr_protected :id
  attr_readonly :permalink
  
  named_scope :active, :conditions => ["active = ?", true], :order => "updated_at DESC"
  named_scope :inactive, :conditions => ["active = ?", false], :order => "updated_at DESC"
  
  include Permalink
  before_validation_on_create :update_permalink

  before_save :deactivate_children

  def inherited_active?
    self.active? && self.category.inherited_active?
  end

protected

  def update_permalink
    self.permalink = generate_permalink_for(self, self.name)
  end

  def deactivate_children
    if self.active_changed? && ! self.active?
      self.forms.each do |form|
        form.update_attribute(:active, false) if form.active?
      end
    end
  end
end
