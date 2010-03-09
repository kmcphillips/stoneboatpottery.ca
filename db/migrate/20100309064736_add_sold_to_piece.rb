class AddSoldToPiece < ActiveRecord::Migration
  def self.up
    add_column :pieces, :sold, :boolean, :default => false
  end

  def self.down
    remove_column :pieces, :sold
  end
end
