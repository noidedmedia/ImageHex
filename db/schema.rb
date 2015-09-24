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

ActiveRecord::Schema.define(version: 20150917030432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collection_images", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "collection_images", ["collection_id"], name: "index_collection_images_on_collection_id", using: :btree
  add_index "collection_images", ["image_id"], name: "index_collection_images_on_image_id", using: :btree
  add_index "collection_images", ["user_id"], name: "index_collection_images_on_user_id", using: :btree

  create_table "collections", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.jsonb    "info"
    t.string   "type"
    t.text     "description"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "curatorships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "level",         default: 0, null: false
  end

  add_index "curatorships", ["collection_id"], name: "index_curatorships_on_collection_id", using: :btree
  add_index "curatorships", ["user_id"], name: "index_curatorships_on_user_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "images", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "f_file_name",      limit: 255
    t.string   "f_content_type",   limit: 255
    t.integer  "license"
    t.integer  "medium"
    t.boolean  "replies_to_inbox",             default: false
    t.jsonb    "exif"
    t.text     "description"
    t.boolean  "nsfw_language",                default: false, null: false
    t.boolean  "nsfw_nudity",                  default: false, null: false
    t.boolean  "nsfw_gore",                    default: false, null: false
    t.boolean  "nsfw_sexuality",               default: false, null: false
  end

  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "subject_id"
    t.string   "subject_type"
    t.boolean  "read",         default: false, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "kind"
  end

  add_index "notifications", ["subject_type", "subject_id"], name: "index_notifications_on_subject_type_and_subject_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "reports", force: :cascade do |t|
    t.integer  "severity"
    t.string   "message",         limit: 255
    t.integer  "reportable_id"
    t.string   "reportable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "reports", ["reportable_id"], name: "index_reports_on_reportable_id", using: :btree
  add_index "reports", ["reportable_type"], name: "index_reports_on_reportable_type", using: :btree
  add_index "reports", ["user_id"], name: "index_reports_on_user_id", using: :btree

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subscriptions", ["collection_id"], name: "index_subscriptions_on_collection_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "tag_group_changes", force: :cascade do |t|
    t.integer  "tag_group_id"
    t.integer  "user_id"
    t.integer  "kind"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "before",       default: [],              array: true
    t.integer  "after",        default: [],              array: true
  end

  add_index "tag_group_changes", ["tag_group_id"], name: "index_tag_group_changes_on_tag_group_id", using: :btree
  add_index "tag_group_changes", ["user_id"], name: "index_tag_group_changes_on_user_id", using: :btree

  create_table "tag_group_members", force: :cascade do |t|
    t.integer  "tag_group_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_group_members", ["tag_group_id"], name: "index_tag_group_members_on_tag_group_id", using: :btree
  add_index "tag_group_members", ["tag_id"], name: "index_tag_group_members_on_tag_id", using: :btree

  create_table "tag_groups", force: :cascade do |t|
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_groups", ["image_id"], name: "index_tag_groups_on_image_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "display_name"
    t.text     "description"
    t.string   "slug"
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "user_pages", force: :cascade do |t|
    t.integer  "user_id"
    t.jsonb    "elsewhere"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "body"
  end

  add_index "user_pages", ["user_id"], name: "index_user_pages_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   limit: 255
    t.integer  "page_pref",                          default: 20
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "role",                               default: 0
    t.string   "slug"
    t.integer  "avatar_id"
    t.string   "provider"
    t.string   "uid"
    t.jsonb    "content_pref",                       default: {}, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "collection_images", "collections"
  add_foreign_key "collection_images", "images", on_delete: :cascade
  add_foreign_key "collection_images", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "curatorships", "collections", on_delete: :cascade
  add_foreign_key "curatorships", "users", on_delete: :cascade
  add_foreign_key "images", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "subscriptions", "collections"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tag_group_changes", "tag_groups", on_delete: :cascade
  add_foreign_key "tag_group_changes", "users", on_delete: :nullify
  add_foreign_key "tag_groups", "images", on_delete: :cascade
  add_foreign_key "user_pages", "users"
  add_foreign_key "users", "images", column: "avatar_id", on_delete: :nullify
end
