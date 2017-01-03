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

ActiveRecord::Schema.define(version: 20170103182601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "citext"

  create_table "artist_subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "artist_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id", "user_id"], name: "index_artist_subscriptions_on_artist_id_and_user_id", unique: true, using: :btree
    t.index ["artist_id"], name: "index_artist_subscriptions_on_artist_id", using: :btree
    t.index ["user_id"], name: "index_artist_subscriptions_on_user_id", using: :btree
  end

  create_table "background_references", force: :cascade do |t|
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "commission_background_id", null: false
    t.text     "description"
    t.index ["commission_background_id"], name: "index_background_references_on_commission_background_id", using: :btree
  end

  create_table "collection_images", force: :cascade do |t|
    t.integer  "collection_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.index ["collection_id", "image_id"], name: "index_collection_images_on_collection_id_and_image_id", unique: true, using: :btree
    t.index ["collection_id"], name: "index_collection_images_on_collection_id", using: :btree
    t.index ["image_id"], name: "index_collection_images_on_image_id", using: :btree
    t.index ["user_id"], name: "index_collection_images_on_user_id", using: :btree
  end

  create_table "collections", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.jsonb    "info"
    t.text     "description"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "user_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "conversation_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "last_read_at"
    t.boolean  "accepted"
    t.index ["conversation_id"], name: "index_conversation_users_on_conversation_id", using: :btree
    t.index ["user_id", "conversation_id"], name: "index_conversation_users_on_user_id_and_conversation_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_conversation_users_on_user_id", using: :btree
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.datetime "last_message_at"
    t.string   "name",            default: "Untitled Conversation", null: false
    t.integer  "order_id"
  end

  create_table "curatorships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "level",         default: 0, null: false
    t.index ["collection_id"], name: "index_curatorships_on_collection_id", using: :btree
    t.index ["user_id"], name: "index_curatorships_on_user_id", using: :btree
  end

  create_table "disputes", force: :cascade do |t|
    t.text     "description"
    t.integer  "order_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "resolved",    default: false, null: false
    t.index ["order_id"], name: "index_disputes_on_order_id", using: :btree
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "image_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_favorites_on_image_id", using: :btree
    t.index ["user_id", "image_id"], name: "index_favorites_on_user_id_and_image_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_favorites_on_user_id", using: :btree
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree
  end

  create_table "image_reports", force: :cascade do |t|
    t.integer  "image_id"
    t.integer  "user_id"
    t.integer  "reason"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.text     "message"
    t.boolean  "active",     default: true, null: false
    t.index ["image_id"], name: "index_image_reports_on_image_id", using: :btree
    t.index ["user_id"], name: "index_image_reports_on_user_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "f_file_name",        limit: 255
    t.string   "f_content_type",     limit: 255
    t.integer  "license"
    t.integer  "medium"
    t.boolean  "replies_to_inbox",               default: true,  null: false
    t.jsonb    "exif"
    t.text     "description"
    t.boolean  "nsfw_language",                  default: false, null: false
    t.boolean  "nsfw_nudity",                    default: false, null: false
    t.boolean  "nsfw_gore",                      default: false, null: false
    t.boolean  "nsfw_sexuality",                 default: false, null: false
    t.integer  "f_file_size"
    t.string   "source"
    t.boolean  "allow_new_creators",             default: false, null: false
    t.index ["user_id"], name: "index_images_on_user_id", using: :btree
  end

  create_table "listing_images", force: :cascade do |t|
    t.integer  "image_id"
    t.integer  "listing_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_id"], name: "index_listing_images_on_image_id", using: :btree
    t.index ["listing_id"], name: "index_listing_images_on_listing_id", using: :btree
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "description",                    null: false
    t.string   "name",                           null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "confirmed",      default: false, null: false
    t.boolean  "open",           default: false, null: false
    t.boolean  "nsfw_nudity",    default: false, null: false
    t.boolean  "nsfw_gore",      default: false, null: false
    t.boolean  "nsfw_language",  default: false, null: false
    t.boolean  "nsfw_sexuality", default: false, null: false
    t.index ["user_id"], name: "index_listings_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.text     "body"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "read",       default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "kind"
    t.jsonb    "subject",    default: {},    null: false
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "order_reference_group_images", force: :cascade do |t|
    t.integer  "order_reference_group_id"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
    t.boolean  "img_processing"
    t.index ["order_reference_group_id"], name: "index_order_reference_group_images_on_order_reference_group_id", using: :btree
  end

  create_table "order_reference_group_tags", force: :cascade do |t|
    t.integer  "order_reference_group_id", null: false
    t.integer  "tag_id",                   null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "order_reference_groups", force: :cascade do |t|
    t.integer  "order_id"
    t.text     "description", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["order_id"], name: "index_order_reference_groups_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "user_id"
    t.text     "description"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "confirmed",    default: false, null: false
    t.integer  "final_price"
    t.boolean  "accepted",     default: false, null: false
    t.datetime "confirmed_at"
    t.datetime "accepted_at"
    t.text     "charge_id"
    t.datetime "charged_at"
    t.integer  "image_id"
    t.datetime "filled_at"
    t.boolean  "rejected",     default: false, null: false
    t.datetime "rejected_at"
    t.string   "name",         default: "",    null: false
    t.index ["listing_id"], name: "index_orders_on_listing_id", using: :btree
    t.index ["user_id"], name: "index_orders_on_user_id", using: :btree
  end

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "collection_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["collection_id"], name: "index_subscriptions_on_collection_id", using: :btree
    t.index ["user_id"], name: "index_subscriptions_on_user_id", using: :btree
  end

  create_table "tag_changes", force: :cascade do |t|
    t.integer  "tag_id"
    t.text     "name"
    t.text     "description"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "user_id"
    t.integer  "importance",  default: 1, null: false
    t.index ["tag_id"], name: "index_tag_changes_on_tag_id", using: :btree
  end

  create_table "tag_group_changes", force: :cascade do |t|
    t.integer  "tag_group_id"
    t.integer  "user_id"
    t.integer  "kind"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "before",       default: [],              array: true
    t.integer  "after",        default: [],              array: true
    t.index ["tag_group_id"], name: "index_tag_group_changes_on_tag_group_id", using: :btree
    t.index ["user_id"], name: "index_tag_group_changes_on_user_id", using: :btree
  end

  create_table "tag_group_members", force: :cascade do |t|
    t.integer  "tag_group_id"
    t.integer  "tag_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["tag_group_id", "tag_id"], name: "index_tag_group_members_on_tag_group_id_and_tag_id", unique: true, using: :btree
    t.index ["tag_group_id"], name: "index_tag_group_members_on_tag_group_id", using: :btree
    t.index ["tag_id"], name: "index_tag_group_members_on_tag_id", using: :btree
  end

  create_table "tag_groups", force: :cascade do |t|
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["image_id"], name: "index_tag_groups_on_image_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.citext   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.string   "slug"
    t.integer  "importance",  default: 1, null: false
    t.index ["name"], name: "index_tags_on_name", unique: true, using: :btree
    t.index ["slug"], name: "index_tags_on_slug", unique: true, using: :btree
  end

  create_table "user_creations", force: :cascade do |t|
    t.integer  "user_id",     null: false
    t.integer  "creation_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["creation_id"], name: "index_user_creations_on_creation_id", using: :btree
    t.index ["user_id", "creation_id"], name: "index_user_creations_on_user_id_and_creation_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_user_creations_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                     limit: 255, default: "",                                                                                                                  null: false
    t.string   "encrypted_password",        limit: 255, default: "",                                                                                                                  null: false
    t.string   "reset_password_token",      limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,                                                                                                                   null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",        limit: 255
    t.string   "last_sign_in_ip",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                      limit: 255
    t.integer  "page_pref",                             default: 20
    t.string   "confirmation_token",        limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",         limit: 255
    t.integer  "role",                                  default: 0
    t.string   "slug"
    t.string   "provider"
    t.string   "uid"
    t.jsonb    "content_pref",                          default: {},                                                                                                                  null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_otp_secret"
    t.string   "encrypted_otp_secret_iv"
    t.string   "encrypted_otp_secret_salt"
    t.integer  "consumed_timestep"
    t.boolean  "otp_required_for_login"
    t.text     "description",                           default: "",                                                                                                                  null: false
    t.jsonb    "elsewhere"
    t.boolean  "two_factor_verified",                   default: false,                                                                                                               null: false
    t.string   "otp_backup_codes",                                                                                                                                                                 array: true
    t.text     "stripe_publishable_key"
    t.text     "stripe_access_token"
    t.text     "stripe_user_id"
    t.boolean  "subscribed_to_newsletter",              default: false,                                                                                                               null: false
    t.boolean  "use_infinite_scroll",                   default: true,                                                                                                                null: false
    t.jsonb    "notifications_pref",                    default: {"order_paid"=>true, "order_filled"=>true, "new_subscriber"=>true, "order_accepted"=>true, "order_confirmed"=>true}, null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  end

  add_foreign_key "artist_subscriptions", "users", column: "artist_id", on_delete: :cascade
  add_foreign_key "artist_subscriptions", "users", on_delete: :cascade
  add_foreign_key "collection_images", "collections", on_delete: :cascade
  add_foreign_key "collection_images", "images", on_delete: :cascade
  add_foreign_key "collection_images", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "conversation_users", "conversations", on_delete: :cascade
  add_foreign_key "conversation_users", "users", on_delete: :cascade
  add_foreign_key "conversations", "orders", on_delete: :nullify
  add_foreign_key "curatorships", "collections", on_delete: :cascade
  add_foreign_key "curatorships", "users", on_delete: :cascade
  add_foreign_key "disputes", "orders"
  add_foreign_key "favorites", "images", on_delete: :cascade
  add_foreign_key "favorites", "users", on_delete: :cascade
  add_foreign_key "image_reports", "images", on_delete: :cascade
  add_foreign_key "image_reports", "users", on_delete: :cascade
  add_foreign_key "images", "users"
  add_foreign_key "listing_images", "images", on_delete: :cascade
  add_foreign_key "listing_images", "listings", on_delete: :cascade
  add_foreign_key "listings", "users", on_delete: :cascade
  add_foreign_key "messages", "conversations", on_delete: :cascade
  add_foreign_key "messages", "users", on_delete: :cascade
  add_foreign_key "notifications", "users"
  add_foreign_key "order_reference_group_images", "order_reference_groups"
  add_foreign_key "order_reference_group_tags", "order_reference_groups", on_delete: :cascade
  add_foreign_key "order_reference_group_tags", "tags", on_delete: :cascade
  add_foreign_key "order_reference_groups", "orders"
  add_foreign_key "orders", "images", on_delete: :restrict
  add_foreign_key "orders", "listings"
  add_foreign_key "orders", "users"
  add_foreign_key "subscriptions", "collections"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "tag_changes", "tags", on_delete: :cascade
  add_foreign_key "tag_changes", "users", on_delete: :cascade
  add_foreign_key "tag_group_changes", "tag_groups", on_delete: :cascade
  add_foreign_key "tag_group_changes", "users", on_delete: :nullify
  add_foreign_key "tag_groups", "images", on_delete: :cascade
  add_foreign_key "user_creations", "images", column: "creation_id", on_delete: :cascade
  add_foreign_key "user_creations", "users", on_delete: :cascade
end
