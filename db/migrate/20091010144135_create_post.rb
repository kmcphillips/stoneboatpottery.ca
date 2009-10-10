class CreatePost < ActiveRecord::Migration
  def self.up
    create_table :posts, :force => true do |t|
      t.string :title
      t.text :body
      t.boolean :generated, :default => false
      t.text :permalink
      
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
