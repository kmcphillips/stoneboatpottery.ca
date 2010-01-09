class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  has_attached_file :image, 
    :styles => { :full => "700x560>", :thumb => "120x120#", :inline => "280x280>" }, 
    :default_style => :full, 
    :whiny => true,
    :path => ":rails_root/public/images/attachment/:class/:attachment/:id/:style_:basename.:extension",
    :url => "/images/attachment/:class/:attachment/:id/:style_:basename.:extension"

  validates_attachment_presence :image
  validates_attachment_size :image, :in => 1..3.megabytes
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/pjpeg", "image/png", "image/tiff", "image/x-png", "image/gif"]

  validates_presence_of :imageable_type, :imageable_id

  named_scope :primary_first, :order => "`primary` DESC, updated_at DESC"

  def thumb
    self.image.url(:thumb)
  end

  def full
    self.image.url(:full)
  end

  def inline
    self.image.url(:inline)
  end

#  before_destroy :delete_images, :make_another_primary

#  before_save :set_primary_false_for_single
#  after_save :manage_primary

#  has_attachment :content_type => :image,
#                 :storage => :file_system,
#                 :path_prefix => "public/images/attachment/",
#                 :resize_to => '700x560>',
#                 :thumbnails => { :thumb => '120x120>' , :inline => "280x280>"}
#  
#  validates_presence_of :filename, :content_type, :size
#  validates_presence_of :imageable_type, :imageable_id, :if => Proc.new {|image| image.is_full_image? }
##  validates_as_attachment
#  
#  attr_protected :id

#  named_scope :full, :conditions => "thumbnail IS NULL"

#  def thumb(name)
#    self.thumbnails.find_by_thumbnail(name.to_s)
#  end

#  def is_full_image?
#    return ! parent_id
#  end

#protected

#  def delete_images
#    if is_full_image?
#      Image.all(:conditions => ["parent_id = ?", self.id]).each {|img| img.destroy }
#    end
#    
#    begin  
#      FileUtils.rm(self.full_filename)
#    rescue => e
#      logger.error "Error deleting image from disk"
#      logger.error e, e.backtrace     
#    end
#  end

#  def set_primary_false_for_single
#    self.primary = false if is_full_image? && self.imageable.andand.respond_to?(:image) && self.primary
#  end

#  def manage_primary
#    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.primary_changed? && self.primary?
#      self.imageable.images.update_all "`primary` = 0", ["id != ? AND `primary` = ?", self.id, true]
#    end

#    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.imageable.andand.images.size == 1 && ! self.primary?
#      self.update_attribute(:primary, true)
#    end
#  end

#  def make_another_primary
#    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.primary?
#      self.imageable.images.first(:conditions => ["id != ?", self.id], :order => "created_at ASC").andand.update_attribute(:primary, true)
#    end
#  end
  
end
