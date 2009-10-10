class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.string :path
      t.boolean :primary, :default => false
      
      t.references :imageable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
