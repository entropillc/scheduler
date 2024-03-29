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

ActiveRecord::Schema.define(:version => 20111125031157) do

  create_table "events", :force => true do |t|
    t.string   "customer_name"
    t.integer  "customer_id"
    t.date     "event_date"
    t.text     "notes"
    t.integer  "room_id"
    t.integer  "party_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.date     "note_date"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
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

end
