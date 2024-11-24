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

ActiveRecord::Schema[7.1].define(version: 2024_11_25_205246) do
  create_table "assignments", force: :cascade do |t|
    t.integer "secret_santa_id", null: false
    t.integer "giver_id", null: false
    t.integer "receiver_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["giver_id"], name: "index_assignments_on_giver_id"
    t.index ["receiver_id"], name: "index_assignments_on_receiver_id"
    t.index ["secret_santa_id"], name: "index_assignments_on_secret_santa_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "secret_santa_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secret_santa_id"], name: "index_participants_on_secret_santa_id"
    t.index ["user_id", "secret_santa_id"], name: "index_participants_on_user_id_and_secret_santa_id", unique: true
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "secret_santa", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id", null: false
    t.index ["code"], name: "index_secret_santa_on_code", unique: true
    t.index ["creator_id"], name: "index_secret_santa_on_creator_id"
    t.index ["name"], name: "index_secret_santa_on_name"
  end

  create_table "user_preferences", force: :cascade do |t|
    t.string "nickname"
    t.string "age"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_preferences_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "assignments", "secret_santa"
  add_foreign_key "assignments", "users", column: "giver_id"
  add_foreign_key "assignments", "users", column: "receiver_id"
  add_foreign_key "participants", "secret_santas"
  add_foreign_key "participants", "users"
  add_foreign_key "secret_santa", "users", column: "creator_id"
  add_foreign_key "user_preferences", "users"
end
