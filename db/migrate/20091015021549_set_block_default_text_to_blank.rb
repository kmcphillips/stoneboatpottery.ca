class SetBlockDefaultTextToBlank < ActiveRecord::Migration
  def self.up
    drop_table :blocks
    create_table :blocks do |t|
      t.text :body, :default => ""
      t.string :title
      t.string :label

      t.timestamps
    end
  end

  def self.down
    drop_table :blocks
    create_table :blocks do |t|
      t.text :body
      t.text :title
      t.text :label

      t.timestamps
    end
  end
end
