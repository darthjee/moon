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

ActiveRecord::Schema.define(version: 2023_07_10_114706) do

  create_table "bank_accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "bank_id"
    t.integer "marriage_id"
    t.string "agency"
    t.string "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "document", limit: 14
    t.string "name"
    t.string "account_type", limit: 10, default: "savings"
  end

  create_table "bank_banks", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "bg_color", limit: 7, default: "#fff"
  end

  create_table "comment_comments", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "text"
    t.integer "thread_id"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comment_threads", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "name"
    t.string "status", limit: 14, default: "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mandrill_email_settings", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key"
    t.string "template_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marriage_albums", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "name", limit: 30
    t.string "status", limit: 10, default: "display"
    t.integer "album_id"
    t.integer "order", limit: 1, default: 0, null: false
  end

  create_table "marriage_events", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.time "time"
    t.integer "marriage_id"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "location_id"
  end

  create_table "marriage_gift_links", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "gift_id"
    t.integer "store_list_id"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float "price"
    t.integer "account_id"
    t.string "status", default: "open"
  end

  create_table "marriage_gifts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "marriage_guests", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "invite_id"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "presence"
    t.string "color", limit: 7
    t.string "role", limit: 20
    t.boolean "active", default: true, null: false
  end

  create_table "marriage_invites", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "marriage_id"
    t.string "label"
    t.integer "invites"
    t.integer "expected"
    t.integer "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "marriage_locations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.text "map_url"
    t.string "instruction"
    t.integer "marriage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marriage_marriages", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.date "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "display_name"
  end

  create_table "marriage_pictures", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "album_id"
    t.string "name", limit: 14
    t.string "url"
    t.string "snap_url"
    t.string "status", limit: 10, default: "display"
  end

  create_table "store_lists", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "store_id"
    t.integer "marriage_id"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "store_stores", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "bg_color", limit: 7, default: "#fff"
  end

  create_table "users", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "authentication_token"
    t.string "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "password", limit: 64
    t.string "login"
    t.string "encrypted_password", limit: 64
    t.string "salt", limit: 64
  end

end
