class UpdateBlockToRemoveTitleAndAddImageBoolean < ActiveRecord::Migration
  def self.up
    remove_column :blocks, :title
    add_column :blocks, :accepts_image, :boolean, :default => false
  end

  def self.down
    add_column :blocks, :title, :string
    remove_column :blocks, :accepts_image
  end
end
