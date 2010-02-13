class FixPermalinkOnPosts < ActiveRecord::Migration
  def self.up
    change_column :posts, :permalink, :string
  end

  def self.down
    change_column :posts, :permalink, :text
  end
end
