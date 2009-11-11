class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  before_destroy :delete_images, :manage_primary

  after_create :manage_primary

  after_update :manage_primary

  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => "public/images/attachment/",
                 :resize_to => '700x700>',
                 :thumbnails => { :small => '120x120>' , :large => "300x300>"}
  
  validates_presence_of :filename, :content_type, :size
#  validates_as_attachment
  
  attr_protected :id

  named_scope :full, :conditions => "thumbnail IS NULL"

  def make_primary
    # TODO this is broken
    raise StandardError, "Must be associated to an object to make it the default" unless self.imageable
    self.update_attribute(:primary, true)
    Image.full.all(:conditions => ["imageable_type = ? AND imageable_id = ? AND id != ?", self.imageable_type, self.imageable_id, self.id]).each do |img|
      img.update_attribute(:primary, false)
    end
  end

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
    rescue
      # TODO log failed delete
    end
  end

  def manage_primary
    # TODO this is broken
    if is_full_image? && self.imageable.respond_to?(:images) && self.imageable.images.first(:conditions => ["id != ? AND `primary` = ?", self.id, true]).nil?
      self.imageable.images.first(:conditions => {:primary => false}, :order => "updated_at DESC").andand.update_attribute(:primary, true)
    end
  end
  
end
