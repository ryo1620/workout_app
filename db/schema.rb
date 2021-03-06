# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_30_105358) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: :cascade do |t|
    t.string "email", null: false
    t.text "message", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "item_records", force: :cascade do |t|
    t.string "name", null: false
    t.integer "weight"
    t.integer "reps"
    t.integer "seconds"
    t.integer "sets"
    t.boolean "checked", default: false
    t.date "date", null: false
    t.bigint "user_id", null: false
    t.bigint "menu_record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_record_id"], name: "index_item_records_on_menu_record_id"
    t.index ["user_id"], name: "index_item_records_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "default", default: false
    t.bigint "user_id", null: false
    t.bigint "part_id", null: false
    t.bigint "type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["part_id"], name: "index_items_on_part_id"
    t.index ["type_id"], name: "index_items_on_type_id"
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "menu_items", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "menu_id", null: false
    t.bigint "item_id", null: false
    t.integer "weight"
    t.integer "reps"
    t.integer "seconds"
    t.integer "sets"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_menu_items_on_item_id"
    t.index ["menu_id"], name: "index_menu_items_on_menu_id"
    t.index ["user_id"], name: "index_menu_items_on_user_id"
  end

  create_table "menu_records", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "checked", default: false
    t.date "date", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_menu_records_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "admin", default: false
    t.decimal "height", precision: 4, scale: 1
    t.decimal "body_weight", precision: 4, scale: 1
    t.decimal "body_fat", precision: 3, scale: 1
    t.decimal "bench_press", precision: 3
    t.decimal "squat", precision: 3
    t.decimal "deadlift", precision: 3
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_menus", force: :cascade do |t|
    t.integer "cwday", null: false
    t.bigint "user_id", null: false
    t.bigint "menu_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["menu_id"], name: "index_week_menus_on_menu_id"
    t.index ["user_id"], name: "index_week_menus_on_user_id"
  end

  add_foreign_key "item_records", "menu_records"
  add_foreign_key "item_records", "users"
  add_foreign_key "items", "parts"
  add_foreign_key "items", "types"
  add_foreign_key "items", "users"
  add_foreign_key "menu_items", "items"
  add_foreign_key "menu_items", "menus"
  add_foreign_key "menu_items", "users"
  add_foreign_key "menu_records", "users"
  add_foreign_key "menus", "users"
  add_foreign_key "week_menus", "menus"
  add_foreign_key "week_menus", "users"
end
