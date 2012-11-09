class RemoveWholesale < ActiveRecord::Migration
  def up
    drop_table :wholesale_passwords
    remove_column :forms, :wholesale_price

    Block.where(:label => "wholesale").destroy_all
  end

  def down
    create_table "wholesale_passwords", :force => true do |t|
      t.string   "password"
      t.boolean  "active",     :default => true
      t.datetime "expires_at"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index "wholesale_passwords", ["active"], :name => "index_wholesale_passwords_on_active"
    add_index "wholesale_passwords", ["password"], :name => "index_wholesale_passwords_on_password"

    add_column :forms, :wholesale_price, :float, :default => 0.0
  end
end
