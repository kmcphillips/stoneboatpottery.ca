class ChangeFromAttachmentFuToPaperclip < ActiveRecord::Migration
  def self.up
    # remove attachment_fu image processing and replace with paperclip
    drop_table :images
    create_table :images, :force => true do |t|
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size
      t.boolean :primary, :default => false
      t.integer :imageable_id
      t.string :imageable_type
      t.timestamps
    end

    # single image on posts
#    add_column :posts, :image_file_name, :string
#    add_column :posts, :image_content_type, :string
#    add_column :posts, :image_file_size, :integer
  end

  def self.down
    drop_table :images
    create_table "images", :force => true do |t|
      t.string   "filename"
      t.boolean  "primary",        :default => false
      t.string   "content_type"
      t.integer  "size"
      t.integer  "height"
      t.integer  "width"
      t.integer  "parent_id"
      t.string   "thumbnail"
      t.integer  "imageable_id"
      t.string   "imageable_type"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

#    remove_column :posts, :image_file_name
#    remove_column :posts, :image_content_type
#    remove_column :posts, :image_file_size
  end
end
