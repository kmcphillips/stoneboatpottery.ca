class AddTypeToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :type, :string
    remove_column :posts, :generated
  end

  def self.down
    remove_column :posts, :type
    add_column :posts, :generated, :boolean
  end
end
