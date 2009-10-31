class AddSectionPathToBlock < ActiveRecord::Migration
  def self.up
    add_column :blocks, :section_path, :string, :default => ""
  end

  def self.down
    remove_column :blocks, :section_path
  end
end
