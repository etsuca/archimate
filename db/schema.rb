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

ActiveRecord::Schema.define(version: 2023_05_24_144442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "architecture", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.string "architect"
    t.text "description"
    t.integer "open_range", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "images"
    t.integer "experience", null: false
    t.index ["user_id"], name: "index_architecture_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "architecture_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["architecture_id"], name: "index_likes_on_architecture_id"
    t.index ["user_id", "architecture_id"], name: "index_likes_on_user_id_and_architecture_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "tag_architecture_relationships", force: :cascade do |t|
    t.bigint "architecture_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["architecture_id"], name: "index_tag_architecture_relationships_on_architecture_id"
    t.index ["tag_id", "architecture_id"], name: "tag_archi_relationships", unique: true
    t.index ["tag_id"], name: "index_tag_architecture_relationships_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "architecture", "users"
  add_foreign_key "likes", "architecture"
  add_foreign_key "likes", "users"
  add_foreign_key "tag_architecture_relationships", "architecture"
  add_foreign_key "tag_architecture_relationships", "tags"
end
