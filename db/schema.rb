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

ActiveRecord::Schema.define(:version => 20111114113334) do

  create_table "brands", :force => true do |t|
    t.string "brand", :limit => 30, :null => false
  end

  create_table "categories", :force => true do |t|
    t.string "category", :limit => 30,                                                :null => false
    t.string "image",    :limit => 80, :default => "images/categories/categorie.gif", :null => false
  end

  create_table "customers", :force => true do |t|
    t.string "first_name",     :limit => 75, :null => false
    t.string "last_name",      :limit => 75, :null => false
    t.string "account_number", :limit => 30
    t.string "address",        :limit => 80
    t.string "city",           :limit => 50
    t.string "pcode",          :limit => 30
    t.string "state",          :limit => 50
    t.string "country",        :limit => 50
    t.string "phone_number",   :limit => 25
    t.string "email",          :limit => 80
    t.binary "comments"
  end

  create_table "discounts", :force => true do |t|
    t.integer "item_id",     :null => false
    t.integer "percent_off", :null => false
    t.binary  "comment"
  end

  create_table "events", :force => true do |t|
    t.string   "customer_name"
    t.integer  "customer_id"
    t.date     "event_date"
    t.text     "notes"
    t.integer  "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string  "item_name",            :limit => 30,                                      :null => false
    t.string  "item_number",          :limit => 20
    t.binary  "description"
    t.integer "brand_id"
    t.integer "category_id"
    t.integer "supplier_id"
    t.string  "buy_price",            :limit => 30,                                      :null => false
    t.string  "unit_price",           :limit => 30,                                      :null => false
    t.string  "supplier_item_number", :limit => 50
    t.string  "tax_percent",          :limit => 10,                                      :null => false
    t.string  "total_cost",           :limit => 30,                                      :null => false
    t.integer "quantity"
    t.integer "reorder_level"
    t.string  "image",                :limit => 80, :default => "images/items/item.gif"
  end

  create_table "pre_sales", :force => true do |t|
    t.date    "date",                          :null => false
    t.integer "customer_id"
    t.string  "sale_sub_total",  :limit => 30, :null => false
    t.string  "sale_total_cost", :limit => 30, :null => false
    t.string  "paid_with",       :limit => 50
    t.integer "items_purchased",               :null => false
    t.integer "sold_by",                       :null => false
    t.binary  "comment"
  end

  create_table "pre_sales_items", :force => true do |t|
    t.integer "sale_id",                          :null => false
    t.integer "item_id",                          :null => false
    t.integer "quantity_purchased",               :null => false
    t.string  "item_unit_price",    :limit => 30, :null => false
    t.string  "item_buy_price",     :limit => 30, :null => false
    t.string  "item_tax_percent",   :limit => 10, :null => false
    t.string  "item_total_tax",     :limit => 30, :null => false
    t.string  "item_total_cost",    :limit => 30, :null => false
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales", :force => true do |t|
    t.date    "date",                          :null => false
    t.integer "customer_id"
    t.string  "sale_sub_total",  :limit => 30, :null => false
    t.string  "sale_total_cost", :limit => 30, :null => false
    t.string  "paid_with",       :limit => 50
    t.integer "items_purchased",               :null => false
    t.integer "sold_by",                       :null => false
    t.binary  "comment"
  end

  create_table "sales_items", :force => true do |t|
    t.integer "sale_id",                          :null => false
    t.integer "item_id",                          :null => false
    t.integer "quantity_purchased",               :null => false
    t.string  "item_unit_price",    :limit => 30, :null => false
    t.string  "item_buy_price",     :limit => 30, :null => false
    t.string  "item_tax_percent",   :limit => 10, :null => false
    t.string  "item_total_tax",     :limit => 30, :null => false
    t.string  "item_total_cost",    :limit => 30, :null => false
  end

  create_table "suppliers", :force => true do |t|
    t.string "supplier",     :limit => 80, :null => false
    t.string "address",      :limit => 80
    t.string "city",         :limit => 50
    t.string "pcode",        :limit => 30
    t.string "state",        :limit => 50
    t.string "country",      :limit => 50
    t.string "phone_number", :limit => 25
    t.string "contact",      :limit => 60
    t.string "email",        :limit => 80
    t.binary "comments"
  end

  create_table "time_availables", :force => true do |t|
    t.string   "name"
    t.integer  "display_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_markers", :force => true do |t|
    t.integer  "time_available_id"
    t.integer  "event_id"
    t.integer  "room_id"
    t.string   "customer"
    t.date     "marker_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string "first_name", :limit => 75, :null => false
    t.string "last_name",  :limit => 75, :null => false
    t.string "username",   :limit => 20, :null => false
    t.string "password",   :limit => 60, :null => false
    t.string "type",       :limit => 30
  end

end
