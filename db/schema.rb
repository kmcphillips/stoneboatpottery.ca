# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100109171121) do

  create_table "blocks", :force => true do |t|
    t.text     "body"
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "section_path",  :default => ""
    t.boolean  "accepts_image", :default => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "permalink"
    t.boolean  "active",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "wholesale_price", :default => 0.0
    t.float    "retail_price",    :default => 0.0
    t.boolean  "active",          :default => true
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.boolean  "primary",            :default => false
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pieces", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "price",       :default => 0.0
    t.boolean  "for_sale",    :default => false
    t.boolean  "active",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "generated",  :default => false
    t.text     "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcategories", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "permalink"
    t.boolean  "active",      :default => true
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wholesale_passwords", :force => true do |t|
    t.string   "password"
    t.boolean  "active",     :default => true
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
