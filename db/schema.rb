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

ActiveRecord::Schema.define(version: 20180828191305) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.boolean "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "event_image_file_name"
    t.string "event_image_content_type"
    t.integer "event_image_file_size"
    t.datetime "event_image_updated_at"
    t.boolean "featured", default: false
    t.datetime "start_time"
    t.boolean "no_start_time", default: true
    t.string "location"
    t.string "fb_id"
  end

  create_table "facebook_tokens", force: :cascade do |t|
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "magma_shows", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "date"
    t.string "link"
    t.text "body"
    t.string "venue"
    t.string "poster_image_file_name"
    t.string "poster_image_content_type"
    t.integer "poster_image_file_size"
    t.datetime "poster_image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "air_times"
    t.string "rebroadcast_times"
    t.string "external_link_name"
    t.string "external_link"
    t.boolean "archived", default: false, null: false
    t.string "program_image_file_name"
    t.string "program_image_content_type"
    t.integer "program_image_file_size"
    t.datetime "program_image_updated_at"
    t.boolean "is_broadcasting", default: false, null: false
    t.datetime "broadcast_starttime"
    t.text "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "twitter_id", limit: 15
    t.string "mixcloud"
  end

  create_table "programs_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "program_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "year"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "login"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "dj_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
