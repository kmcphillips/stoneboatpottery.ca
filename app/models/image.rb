class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  before_destroy :delete_images, :make_another_primary

  before_save :set_primary_false_for_single
  after_save :manage_primary

  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => "public/images/attachment/",
                 :resize_to => '750x750>',
                 :thumbnails => { :thumb => '120x120>' , :inline => "280x280>"}
  
  validates_presence_of :filename, :content_type, :size
  validates_presence_of :imageable_type, :imageable_id, :if => Proc.new {|image| image.is_full_image? }
#  validates_as_attachment
  
  attr_protected :id

  named_scope :full, :conditions => "thumbnail IS NULL"

  def thumb(name)
    self.thumbnails.find_by_thumbnail(name.to_s)
  end

  def is_full_image?
    return ! parent_id
  end

protected

  def delete_images
    if is_full_image?
      Image.all(:conditions => ["parent_id = ?", self.id]).each {|img| img.destroy }
    end
    
    begin  
      FileUtils.rm(self.full_filename)
    rescue => e
      logger.error "Error deleting image from disk"
      logger.error e, e.backtrace     
    end
  end

  def set_primary_false_for_single
    self.primary = false if is_full_image? && self.imageable.andand.respond_to?(:image) && self.primary
  end

  def manage_primary
    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.primary_changed? && self.primary?
      self.imageable.images.update_all "`primary` = 0", ["id != ? AND `primary` = ?", self.id, true]
    end

    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.imageable.andand.images.size == 1 && ! self.primary?
      self.update_attribute(:primary, true)
    end
  end

  def make_another_primary
    if is_full_image? && self.imageable.andand.respond_to?(:images) && self.primary?
      self.imageable.images.first(:conditions => ["id != ?", self.id], :order => "created_at ASC").andand.update_attribute(:primary, true)
    end
  end
  
end
