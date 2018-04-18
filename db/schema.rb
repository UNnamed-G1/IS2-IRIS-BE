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

ActiveRecord::Schema.define(version: 20180322060224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "career_research_groups", id: false, force: :cascade do |t|
    t.bigint "career_id"
    t.bigint "research_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id"], name: "index_career_research_groups_on_career_id"
    t.index ["research_group_id"], name: "index_career_research_groups_on_research_group_id"
  end

  create_table "careers", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.bigint "snies_code", null: false
    t.integer "degree_type", default: 0, null: false
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_careers_on_department_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", limit: 100
    t.bigint "faculty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "event_users", id: false, force: :cascade do |t|
    t.integer "type_user_event", default: 0, null: false
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_users_on_event_id"
    t.index ["user_id"], name: "index_event_users_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "research_group_id"
    t.text "topic", null: false
    t.text "description", null: false
    t.integer "type_ev", null: false
    t.datetime "date", null: false
    t.integer "frequence", null: false
    t.time "duration", null: false
    t.integer "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_group_id"], name: "index_events_on_research_group_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.text "picture"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id"
  end

  create_table "publication_research_groups", id: false, force: :cascade do |t|
    t.bigint "publication_id"
    t.bigint "research_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_research_groups_on_publication_id"
    t.index ["research_group_id"], name: "index_publication_research_groups_on_research_group_id"
  end

  create_table "publication_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "publication_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["publication_id"], name: "index_publication_users_on_publication_id"
    t.index ["user_id"], name: "index_publication_users_on_user_id"
  end

  create_table "publications", force: :cascade do |t|
    t.text "name", null: false
    t.date "date", null: false
    t.text "abstract", null: false
    t.text "document"
    t.string "brief_description", limit: 500, null: false
    t.integer "type_pub", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", id: false, force: :cascade do |t|
    t.integer "followed_id"
    t.integer "follower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "research_groups", force: :cascade do |t|
    t.text "name", null: false
    t.text "description", null: false
    t.text "strategic_focus", null: false
    t.text "research_priorities", null: false
    t.date "foundation_date", null: false
    t.integer "classification", null: false
    t.date "date_classification", null: false
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_subject_research_groups", id: false, force: :cascade do |t|
    t.bigint "research_subject_id"
    t.bigint "research_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_group_id"], name: "index_research_subject_research_groups_on_research_group_id"
    t.index ["research_subject_id"], name: "index_research_subject_research_groups_on_research_subject_id"
  end

  create_table "research_subject_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "research_subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_subject_id"], name: "index_research_subject_users_on_research_subject_id"
    t.index ["user_id"], name: "index_research_subject_users_on_user_id"
  end

  create_table "research_subjects", force: :cascade do |t|
    t.string "name", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedule_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_schedule_users_on_schedule_id"
    t.index ["user_id"], name: "index_schedule_users_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "start_hour", null: false
    t.integer "duration", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_research_groups", id: false, force: :cascade do |t|
    t.date "joining_date", null: false
    t.date "end_joining_date", null: false
    t.integer "state", default: 0, null: false
    t.integer "type_urg", default: 0, null: false
    t.integer "hours_per_week", default: 0, null: false
    t.bigint "user_id"
    t.bigint "research_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_group_id"], name: "index_user_research_groups_on_research_group_id"
    t.index ["user_id"], name: "index_user_research_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "lastname", limit: 100, null: false
    t.string "username", limit: 40
    t.string "email", null: false
    t.string "password_digest"
    t.text "professional_profile"
    t.integer "user_type", default: 0, null: false
    t.string "phone", limit: 20
    t.string "office", limit: 20
    t.text "cvlac_link"
    t.boolean "google_sign_up", default: false
    t.bigint "career_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id"], name: "index_users_on_career_id"
  end

  add_foreign_key "career_research_groups", "careers"
  add_foreign_key "career_research_groups", "research_groups"
  add_foreign_key "careers", "departments"
  add_foreign_key "departments", "faculties"
  add_foreign_key "event_users", "events"
  add_foreign_key "event_users", "users"
  add_foreign_key "events", "research_groups"
  add_foreign_key "publication_research_groups", "publications"
  add_foreign_key "publication_research_groups", "research_groups"
  add_foreign_key "publication_users", "publications"
  add_foreign_key "publication_users", "users"
  add_foreign_key "research_subject_research_groups", "research_groups"
  add_foreign_key "research_subject_research_groups", "research_subjects"
  add_foreign_key "research_subject_users", "research_subjects"
  add_foreign_key "research_subject_users", "users"
  add_foreign_key "schedule_users", "schedules"
  add_foreign_key "schedule_users", "users"
  add_foreign_key "user_research_groups", "research_groups"
  add_foreign_key "user_research_groups", "users"
  add_foreign_key "users", "careers"
end
