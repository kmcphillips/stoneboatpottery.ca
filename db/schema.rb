# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121109000539) do

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
    t.text     "description"
    t.string   "permalink"
    t.boolean  "active",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["active"], :name => "index_categories_on_active"
  add_index "categories", ["permalink"], :name => "index_categories_on_permalink"

  create_table "forms", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.float    "retail_price",   :default => 0.0
    t.boolean  "active",         :default => true
    t.integer  "subcategory_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "permalink"
  end

  add_index "forms", ["active"], :name => "index_forms_on_active"
  add_index "forms", ["permalink"], :name => "index_forms_on_permalink"
  add_index "forms", ["subcategory_id"], :name => "index_forms_on_subcategory_id"

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

  add_index "images", ["imageable_id", "imageable_type"], :name => "index_images_on_imageable_id_and_imageable_type"
  add_index "images", ["imageable_id"], :name => "index_images_on_imageable_id"
  add_index "images", ["imageable_type"], :name => "index_images_on_imageable_type"

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "url"
    t.text     "description"
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
    t.string   "type"
    t.boolean  "sold",        :default => false
  end

  add_index "pieces", ["active"], :name => "index_pieces_on_active"
  add_index "pieces", ["permalink"], :name => "index_pieces_on_permalink"
  add_index "pieces", ["type"], :name => "index_pieces_on_type"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "permalink"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "posts", ["permalink"], :name => "index_posts_on_permalink"
  add_index "posts", ["type"], :name => "index_posts_on_type"

  create_table "subcategories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "permalink"
    t.boolean  "active",      :default => true
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subcategories", ["active"], :name => "index_subcategories_on_active"
  add_index "subcategories", ["category_id"], :name => "index_subcategories_on_category_id"
  add_index "subcategories", ["permalink"], :name => "index_subcategories_on_permalink"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], :name => "index_users_on_username"

end
