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

ActiveRecord::Schema.define(version: 20141208024006) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "edit_records", force: true do |t|
    t.integer  "target_id"
    t.string   "target_type"
    t.integer  "user_id"
    t.json     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edit_records", ["user_id"], name: "index_edit_records_on_user_id", using: :btree

  create_table "images", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "f_file_name"
    t.string   "f_content_type"
    t.integer  "f_file_size"
    t.datetime "f_updated_at"
    t.integer  "license"
    t.integer  "medium"
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "reports", force: true do |t|
    t.integer  "severity"
    t.string   "message"
    t.integer  "reportable_id"
    t.string   "reportable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tag_group_members", force: true do |t|
    t.integer  "tag_group_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_group_members", ["tag_group_id"], name: "index_tag_group_members_on_tag_group_id", using: :btree
  add_index "tag_group_members", ["tag_id"], name: "index_tag_group_members_on_tag_id", using: :btree

  create_table "tag_groups", force: true do |t|
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_groups", ["image_id"], name: "index_tag_groups_on_image_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "page_pref",              default: 20
    t.string   "authentication_token"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
