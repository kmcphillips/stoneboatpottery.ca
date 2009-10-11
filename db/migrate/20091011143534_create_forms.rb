class CreateForms < ActiveRecord::Migration
  def self.up
    create_table :forms do |t|
      t.string :name
      t.text :description
      t.float :wholesale_price, :default => 0
      t.float :retail_price, :default => 0
      t.boolean :active, :default => true
      t.integer :subcategory_id

      t.timestamps
    end
  end

  def self.down
    drop_table :forms
  end
end
