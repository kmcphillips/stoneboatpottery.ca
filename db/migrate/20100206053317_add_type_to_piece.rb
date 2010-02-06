class AddTypeToPiece < ActiveRecord::Migration
  def self.up
    add_column :pieces, :type, :string
  end

  def self.down
    remove_column :pieces, :type
  end
end
