class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  SIZES = { :full => "700x560>", :thumb => "120x120#", :inline => "280x280>", :inline_large => "600x400>" }

  has_attached_file :image, 
    :styles => SIZES,
    :default_style => :full, 
    :whiny => true,
    :path => ":rails_root/public/images/attachment/:class/:attachment/:id/:style_:basename.:extension",
    :url => "/images/attachment/:class/:attachment/:id/:style_:basename.:extension"

  before_destroy :make_another_primary

  before_save :set_primary_false_for_single
  after_save :manage_primary

  validates_attachment_presence :image
  validates_attachment_size :image, :in => 1..3.megabytes
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

  validates_presence_of :imageable_type, :imageable_id

  attr_protected :id

  scope :primary_first, order("`primary` DESC, updated_at DESC")
  scope :all_primary, where("`primary` = 1")
  scope :recent, lambda{|limit| order("updated_at DESC").limit(limit).group("imageable_type, imageable_id") }

  # create a convenience method for each of the image sizes/types
  SIZES.each_key do |key|
    define_method key do
      self.image.url(key)
    end
  end

protected

  def set_primary_false_for_single
    self.primary = false if self.imageable.try(:respond_to?, :image) && self.primary?
  end

  def manage_primary
    # Only manage primary if the imageable object has multiple images
    if self.imageable.try(:respond_to?, :images)
      self.imageable.images.update_all("`primary` = 0", ["id != ? AND `primary` = ?", self.id, true]) if self.primary_changed? && self.primary?
      self.update_attribute(:primary, true) if self.imageable.try(:images) && self.imageable.images.size == 1 && ! self.primary?
    end
  end

  def make_another_primary
    if self.imageable.try(:respond_to?, :images) && self.primary?
      self.imageable.images.where(["id != ?", self.id]).order("created_at ASC").first.try(:update_attribute, :primary, true)
    end
  end
  
end
