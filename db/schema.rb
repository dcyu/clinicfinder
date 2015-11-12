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

ActiveRecord::Schema.define(version: 20151112153817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "capabilities", force: :cascade do |t|
    t.integer "topic_id"
    t.integer "clinic_id"
    t.boolean "available"
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "name"
    t.string   "lat"
    t.string   "lng"
    t.text     "address"
    t.text     "operating_hours"
    t.string   "cost"
    t.string   "scheduling"
    t.string   "eligibility"
    t.string   "country"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "organization"
    t.string   "phone"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.text     "additional_info"
    t.boolean  "verified"
  end

  create_table "shifts", force: :cascade do |t|
    t.string  "day"
    t.string  "opening_time"
    t.string  "closing_time"
    t.integer "clinic_id"
    t.boolean "open"
    t.string  "opening_time2"
    t.string  "closing_time2"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.text   "description"
  end

end
