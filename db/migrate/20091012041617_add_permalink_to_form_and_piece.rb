class AddPermalinkToFormAndPiece < ActiveRecord::Migration
  def self.up
    add_column :forms, :permalink, :string
    add_column :pieces, :permalink, :string
  end

  def self.down
    remove_column :forms, :permalink
    remove_column :pieces, :permalink
  end
end
