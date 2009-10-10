class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :path
      t.boolean :primary, :default => false
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
