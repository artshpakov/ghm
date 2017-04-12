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

ActiveRecord::Schema.define(version: 20170412185757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", force: :cascade do |t|
    t.string   "title"
    t.string   "image"
    t.string   "text",       limit: 100
    t.string   "emails",                 default: [],   array: true
    t.json     "settings",               default: {}
    t.boolean  "active",                 default: true
    t.datetime "created_at"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.string   "bootsy_resource_type"
    t.integer  "bootsy_resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "followings", id: false, force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "object_id",   null: false
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider",   null: false
    t.string   "uid",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["provider", "uid"], name: "index_identities_on_provider_and_uid", using: :btree
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",                   null: false
    t.text     "text",                    null: false
    t.string   "slug",                    null: false
    t.string   "tags",       default: [],              array: true
    t.integer  "likes",      default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "kind",                    null: false
    t.json     "settings",   default: {}
    t.index ["user_id"], name: "index_posts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                         null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.json     "profile",          default: {}
    t.string   "roles",            default: [],              array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_uid"
    t.string   "slug",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

end
