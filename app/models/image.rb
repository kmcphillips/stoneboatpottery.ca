class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :path_prefix => "public/images/attachment/",
                 :resize_to => '320x200>',
                 :thumbnails => { :thumb => '100x100>' }
  
#  validates_presence_of :imageable
  validates_presence_of :filename, :content_type, :size, :height, :width
#  validates_as_attachment
  
  attr_protected :id

  def make_primary
    raise StandardError, "Must be associated to an object to make it the default" unless self.imageable
    Image.all(:conditions => ["imageable_type = ? AND imageable_id = ? AND primary = ? AND NOT id = ?", self.imageable_type, self.imageable_id, 1, self.id]) do |img|
      img.update_attribute(:primary, false)
    end
    self.update_attiribute(:primary, true)
  end
end
