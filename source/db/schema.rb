# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_11_133251) do
  create_table "bank_accounts", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "bank_id"
    t.integer "marriage_id"
    t.string "agency"
    t.string "number"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "document", limit: 14
    t.string "name"
    t.string "account_type", limit: 10, default: "savings"
  end

  create_table "bank_banks", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "bg_color", limit: 7, default: "#fff"
  end

  create_table "comment_comments", id: :integer, charset: "utf8", force: :cascade do |t|
    t.text "text"
    t.integer "thread_id"
    t.integer "user_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "comment_threads", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "name"
    t.string "status", limit: 14, default: "active"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "mandrill_email_settings", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "key"
    t.string "template_name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "marriage_albums", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "name", limit: 30
    t.string "status", limit: 10, default: "display"
    t.integer "album_id"
    t.integer "order", limit: 1, default: 0, null: false
  end

  create_table "marriage_events", id: :integer, charset: "utf8", force: :cascade do |t|
    t.time "time"
    t.integer "marriage_id"
    t.string "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "location_id"
  end

  create_table "marriage_gift_links", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "gift_id"
    t.integer "store_list_id"
    t.string "url"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.float "price"
    t.integer "account_id"
    t.string "status", default: "open"
  end

  create_table "marriage_gifts", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "description"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "marriage_id"
    t.integer "quantity", default: 1, null: false
    t.float "min_price", default: 0.0, null: false
    t.float "max_price", default: 0.0, null: false
    t.integer "package", default: 1, null: false
    t.integer "bought", default: 0, null: false
    t.string "status", default: "open"
    t.string "display_type", default: "regular", null: false
    t.integer "thread_id"
  end

  create_table "marriage_guests", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "invite_id"
    t.string "name"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "presence"
    t.string "color", limit: 7
    t.string "role", limit: 20
    t.boolean "active", default: true, null: false
  end

  create_table "marriage_invites", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "label"
    t.integer "invites"
    t.integer "expected"
    t.integer "confirmed"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "code", limit: 4
    t.string "email"
    t.time "last_view_date"
    t.boolean "invite_honor"
    t.string "authentication_token", limit: 16
    t.string "password", limit: 64
    t.string "status", limit: 10, default: "created"
    t.boolean "up_to_date"
    t.boolean "welcome_sent", default: false
    t.integer "user_id"
    t.index ["marriage_id", "code"], name: "index_marriage_invites_on_marriage_id_and_code"
  end

  create_table "marriage_locations", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "map_url"
    t.string "instruction"
    t.integer "marriage_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "marriage_marriages", id: :integer, charset: "utf8", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "display_name"
  end

  create_table "marriage_pictures", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "album_id"
    t.string "name", limit: 14
    t.string "url"
    t.string "snap_url"
    t.string "status", limit: 10, default: "display"
  end

  create_table "store_lists", id: :integer, charset: "utf8", force: :cascade do |t|
    t.integer "store_id"
    t.integer "marriage_id"
    t.string "url"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "store_stores", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "url"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "bg_color", limit: 7, default: "#fff"
  end

  create_table "users", id: :integer, charset: "utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "authentication_token"
    t.string "code"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "login"
    t.string "encrypted_password", limit: 64
    t.string "salt", limit: 64
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login"], name: "index_users_on_login", unique: true
  end

end
