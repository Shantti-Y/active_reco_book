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

ActiveRecord::Schema.define(version: 20170216153022) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "conditions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.integer  "category"
    t.integer  "point",      default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "posts", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "content"
    t.string   "condition"
    t.string   "post_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "published"
  end

  create_table "questions", force: :cascade do |t|
    t.text     "content"
    t.integer  "category"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "question_number"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "employee_number"
    t.string   "division"
    t.string   "gender"
    t.datetime "started_at"
    t.datetime "birthday"
    t.boolean  "employee"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "activated",              default: false
    t.string   "activate_digest"
    t.boolean  "password_reset",         default: true
    t.string   "password_reset_digest"
    t.datetime "password_reset_sent_at"
    t.binary   "thumbnail"
    t.string   "thumbnail_ctype"
  end

end
