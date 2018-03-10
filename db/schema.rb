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

ActiveRecord::Schema.define(version: 20180310171429) do

  create_table "research_subjects", force: :cascade do |t|
    t.string "name", limit: 100
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_subjects_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "research_subject_id", null: false
    t.index ["research_subject_id"], name: "index_research_subjects_users_on_research_subject_id"
    t.index ["user_id"], name: "index_research_subjects_users_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start"
    t.datetime "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules_users", id: false, force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "schedule_id", null: false
    t.index ["schedule_id"], name: "index_schedules_users_on_schedule_id"
    t.index ["user_id"], name: "index_schedules_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 100
    t.string "username", limit: 30
    t.string "professional_profile", limit: 5000
    t.string "email", limit: 50
    t.string "phone", limit: 15
    t.string "office", limit: 15
    t.string "cvlac_link", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
