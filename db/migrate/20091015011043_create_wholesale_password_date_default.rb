class CreateWholesalePasswordDateDefault < ActiveRecord::Migration
  def self.up
    change_column :wholesale_passwords, :expires_at, :datetime, :default => nil
  end

  def self.down
    change_column :wholesale_passwords, :expires_at, :datetime
  end
end
