class CreateBlocks < ActiveRecord::Migration
  def self.up
    create_table :blocks do |t|
      t.text :body
      t.text :title
      t.text :label

      t.timestamps
    end
  end

  def self.down
    drop_table :blocks
  end
end
