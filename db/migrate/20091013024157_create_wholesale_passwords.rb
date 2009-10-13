class CreateWholesalePasswords < ActiveRecord::Migration
  def self.up
    create_table :wholesale_passwords do |t|
      t.string :password
      t.boolean :active, :default => true
      t.datetime :expires_at

      t.timestamps
    end
  end

  def self.down
    drop_table :wholesale_passwords
  end
end
