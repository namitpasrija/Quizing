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

ActiveRecord::Schema.define(version: 20180103134442) do

  create_table "attempts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "test_id"
    t.integer  "problem_id"
    t.string   "answered"
    t.integer  "status"
    t.integer  "marks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "attempts", ["problem_id"], name: "index_attempts_on_problem_id"
  add_index "attempts", ["test_id"], name: "index_attempts_on_test_id"
  add_index "attempts", ["user_id"], name: "index_attempts_on_user_id"

  create_table "participations", force: :cascade do |t|
    t.integer  "test_id"
    t.integer  "user_id"
    t.integer  "score",   :default => 0
    t.integer  "wrongAnswers",   :default => 0
    t.integer  "correctAnswers",   :default => 0
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "maxscore"
  end

  add_index "participations", ["test_id"], name: "index_participations_on_test_id"
  add_index "participations", ["user_id"], name: "index_participations_on_user_id"

  create_table "problems", force: :cascade do |t|
    t.text     "que"
    t.text     "option1"
    t.text     "option2"
    t.text     "option3"
    t.text     "option4"
    t.text     "option5"
    t.text     "option6"
    t.text     "option7"
    t.text     "option8"
    t.text     "option9"
    t.text     "option10"
    t.integer  "testid"
    t.text     "subject"
    t.integer  "marks"
    t.integer  "diffLevel"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "answer"
    t.decimal  "queno"
  end

  add_index "problems", ["user_id"], name: "index_problems_on_user_id"

  create_table "tests", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.integer  "duration"
    t.datetime "startTime"
    t.datetime "endTime"
    t.text     "conductedBy"
    t.integer  "user_id"
    t.integer  "fee"
    t.text     "prize"
    t.text     "instructions"
    t.text     "password"
    t.text     "tType"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "tests", ["user_id"], name: "index_tests_on_user_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
