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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150816000848) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "marriage_events", force: true do |t|
    t.time     "time"
    t.integer  "marriage_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "location"
    t.string   "address"
  end

  create_table "marriage_guests", force: true do |t|
    t.integer  "invite_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "presence"
  end

  create_table "marriage_invites", force: true do |t|
    t.integer  "marriage_id"
    t.string   "label"
    t.integer  "invites"
    t.integer  "expected"
    t.integer  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",        limit: 4
  end

  add_index "marriage_invites", ["marriage_id", "code"], name: "index_marriage_invites_on_marriage_id_and_code", using: :btree

  create_table "marriage_marriages", force: true do |t|
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
  end

end
