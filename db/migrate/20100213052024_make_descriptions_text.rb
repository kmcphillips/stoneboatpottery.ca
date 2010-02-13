class MakeDescriptionsText < ActiveRecord::Migration
  def self.up
    change_column :categories, :description, :text
    change_column :subcategories, :description, :text
    change_column :links, :description, :text
  end

  def self.down
    change_column :categories, :description, :string
    change_column :subcategories, :description, :string
    change_column :links, :description, :string
  end
end
