class CreatePieces < ActiveRecord::Migration
  def self.up
    create_table :pieces do |t|
      t.string :name
      t.text :description
      t.float :price, :default => 0
      t.boolean :for_sale, :default => false
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :pieces
  end
end
