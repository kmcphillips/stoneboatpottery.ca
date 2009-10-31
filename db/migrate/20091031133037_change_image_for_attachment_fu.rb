class ChangeImageForAttachmentFu < ActiveRecord::Migration
  def self.up
    drop_table :images
    create_table :images do |t|
      t.string :filename
      t.boolean  :primary,        :default => false
      t.string :content_type
      t.integer :size
      t.integer :height
      t.integer :width
      t.integer :parent_id
      t.string :thumbnail
      t.integer  :imageable_id
      t.string   :imageable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :images
    create_table :images do |t|
      t.string :path
      t.boolean :primary,        :default => false
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end
end
