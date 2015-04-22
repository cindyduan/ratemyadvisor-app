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

ActiveRecord::Schema.define(version: 20150421130310) do

  create_table "professors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "netid"
    t.string   "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "professors", ["netid"], name: "index_professors_on_netid", unique: true

  create_table "reviews", force: :cascade do |t|
    t.string   "student_netid"
    t.string   "student_class"
    t.string   "professor_netid"
    t.string   "relationship"
    t.integer  "availability"
    t.integer  "responsiveness"
    t.integer  "knowledge"
    t.integer  "organization"
    t.integer  "friendliness"
    t.integer  "helpfulness"
    t.text     "comments"
    t.integer  "professor_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "reviews", ["professor_id", "created_at"], name: "index_reviews_on_professor_id_and_created_at"
  add_index "reviews", ["professor_id"], name: "index_reviews_on_professor_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
