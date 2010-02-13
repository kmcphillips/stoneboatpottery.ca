class AddIndexesGlobally < ActiveRecord::Migration
  def self.up
    add_index :categories, :permalink
    add_index :categories, :active

    add_index :forms, :active
    add_index :forms, :subcategory_id
    add_index :forms, :permalink

    add_index :images, :imageable_id
    add_index :images, :imageable_type
    add_index :images, [:imageable_id, :imageable_type]

    add_index :pieces, :active
    add_index :pieces, :type
    add_index :pieces, :permalink

    add_index :posts, :type
    add_index :posts, :permalink

    add_index :subcategories, :permalink
    add_index :subcategories, :active
    add_index :subcategories, :category_id

    add_index :users, :username

    add_index :wholesale_passwords, :password
    add_index :wholesale_passwords, :active
  end

  def self.down
    remove_index :categories, :permalink
    remove_index :categories, :active

    remove_index :forms, :active
    remove_index :forms, :subcategory_id
    remove_index :forms, :permalink

    remove_index :images, :imageable_id
    remove_index :images, :imageable_type
    remove_index :images, [:imageable_id, :imageable_type]

    remove_index :pieces, :active
    remove_index :pieces, :type
    remove_index :pieces, :permalink

    remove_index :posts, :type
    remove_index :posts, :permalink

    remove_index :subcategories, :permalink
    remove_index :subcategories, :active
    remove_index :subcategories, :category_id

    remove_index :users, :username

    remove_index :wholesale_passwords, :password
    remove_index :wholesale_passwords, :active    
  end
end
