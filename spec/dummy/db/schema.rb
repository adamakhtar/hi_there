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

ActiveRecord::Schema.define(version: 20151010080133) do

  create_table "hi_there_courses", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "workflow_state"
    t.string   "name"
  end

  add_index "hi_there_courses", ["name"], name: "index_hi_there_courses_on_name"
  add_index "hi_there_courses", ["workflow_state"], name: "index_hi_there_courses_on_workflow_state"

  create_table "hi_there_emails", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.integer  "course_id"
    t.integer  "interval",     default: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "issue_number"
  end

  add_index "hi_there_emails", ["course_id"], name: "index_hi_there_emails_on_course_id"
  add_index "hi_there_emails", ["interval"], name: "index_hi_there_emails_on_interval"
  add_index "hi_there_emails", ["issue_number"], name: "index_hi_there_emails_on_issue_number"

  create_table "hi_there_subscriptions", force: :cascade do |t|
    t.string   "email"
    t.string   "workflow_state"
    t.integer  "course_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "token"
    t.integer  "next_issue_number"
    t.datetime "next_delivery_at"
  end

  add_index "hi_there_subscriptions", ["course_id"], name: "index_hi_there_subscriptions_on_course_id"
  add_index "hi_there_subscriptions", ["email"], name: "index_hi_there_subscriptions_on_email"
  add_index "hi_there_subscriptions", ["token"], name: "index_hi_there_subscriptions_on_token"
  add_index "hi_there_subscriptions", ["workflow_state"], name: "index_hi_there_subscriptions_on_workflow_state"

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
