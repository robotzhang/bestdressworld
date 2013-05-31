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

ActiveRecord::Schema.define(:version => 20130531074155) do

  create_table "brands", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "user_id"
    t.string   "website"
    t.text     "introduce"
    t.string   "logo"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slogan"
    t.string   "country"
    t.integer  "year"
    t.string   "good_at"
    t.string   "url_key"
  end

  create_table "categories", :force => true do |t|
    t.integer  "parent_id",  :default => 0, :null => false
    t.string   "code",                      :null => false
    t.string   "name_en"
    t.string   "name_cn"
    t.string   "url_key",                   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_products", :force => true do |t|
    t.integer "product_id",  :null => false
    t.integer "category_id", :null => false
  end

  create_table "descriptions", :force => true do |t|
    t.integer  "product_id", :null => false
    t.text     "features"
    t.text     "content",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discounts", :force => true do |t|
    t.integer  "product_id",     :null => false
    t.float    "price",          :null => false
    t.float    "sale_price"
    t.datetime "sale_date_from"
    t.datetime "sale_date_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", :force => true do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.string   "name"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.text     "url",            :null => false
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order"
  end

  create_table "options", :force => true do |t|
    t.string   "group",      :null => false
    t.string   "code",       :null => false
    t.string   "name_en"
    t.string   "name_cn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options_products", :force => true do |t|
    t.integer "option_id",  :null => false
    t.integer "product_id", :null => false
  end

  create_table "products", :force => true do |t|
    t.string   "asin"
    t.string   "sku"
    t.text     "name",             :null => false
    t.string   "currency"
    t.float    "price"
    t.string   "origin"
    t.text     "buy_url"
    t.text     "from_url"
    t.string   "from_site"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.text     "seo_url"
    t.text     "seo_title"
    t.text     "seo_keywords"
    t.text     "seo_descriptions"
    t.string   "publisher"
    t.string   "studio"
    t.integer  "sales_rank"
    t.integer  "user_id",          :null => false
    t.integer  "updater_id",       :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "product_id", :null => false
    t.text     "content",    :null => false
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "role",            :limit => 8, :default => "user"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

end
