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

ActiveRecord::Schema[7.1].define(version: 2023_12_11_093722) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "qr_codes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "path_alias"
    t.string "destination"
    t.string "domain"
    t.string "png"
    t.string "svg"
    t.integer "visits_amount", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_domain_id"
    t.index ["user_domain_id"], name: "index_qr_codes_on_user_domain_id"
    t.index ["user_id"], name: "index_qr_codes_on_user_id"
  end

  create_table "user_domains", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_domains_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.bigint "qr_code_id", null: false
    t.string "country"
    t.string "referrer"
    t.string "device"
    t.string "os"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["qr_code_id"], name: "index_visits_on_qr_code_id"
  end

  add_foreign_key "qr_codes", "user_domains"
  add_foreign_key "qr_codes", "users"
  add_foreign_key "user_domains", "users"
  add_foreign_key "visits", "qr_codes"
end
