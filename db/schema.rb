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

ActiveRecord::Schema.define(version: 2019_03_23_222536) do

  create_table "friendships", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "group_users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.boolean "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_friends", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "order_id"
    t.string "user_status", default: "invited"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_friends_on_order_id"
    t.index ["user_id", "order_id"], name: "index_order_friends_on_user_id_and_order_id"
    t.index ["user_id"], name: "index_order_friends_on_user_id"
  end

  create_table "order_items", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "user_id"
    t.string "item"
    t.integer "amount"
    t.integer "price"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["user_id"], name: "index_order_items_on_user_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "order_type"
    t.string "restaurant"
    t.binary "menu_image", limit: 4294967295
    t.bigint "user_id"
    t.string "order_status", default: "waiting"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.binary "avatar", limit: 4294967295
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "orders", "users"
end
