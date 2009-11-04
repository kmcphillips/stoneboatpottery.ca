class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  before_destroy :delete_images

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
    raise StandardError, "Must be associated to an object to make it the default" unless self.imageable
    Image.all(:conditions => ["imageable_type = ? AND imageable_id = ? AND primary = ? AND NOT id = ?", self.imageable_type, self.imageable_id, 1, self.id]) do |img|
      img.update_attribute(:primary, false)
    end
    self.update_attiribute(:primary, true)
  end

  def thumb(name)
    self.thumbnails.find_by_thumbnail(name.to_s)
  end

protected

  def delete_images
    unless self.parent_id
      Image.all(:conditions => ["parent_id = ?", self.id]).each {|img| img.destroy }
    end
      
    FileUtils.rm(self.full_filename)
  end
  
end
