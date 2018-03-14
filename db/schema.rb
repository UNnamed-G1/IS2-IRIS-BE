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

ActiveRecord::Schema.define(version: 20180311005308) do

  create_table "careers", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "snies_code", limit: 5, null: false
    t.integer "degree_type", default: 0, null: false
    t.integer "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_careers_on_department_id"
  end

  create_table "careers_research_groups", id: false, force: :cascade do |t|
    t.integer "career_id"
    t.integer "research_group_id"
    t.index ["career_id"], name: "index_careers_research_groups_on_career_id"
    t.index ["research_group_id"], name: "index_careers_research_groups_on_research_group_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", limit: 100
    t.integer "faculty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["faculty_id"], name: "index_departments_on_faculty_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "research_group_id"
    t.text "topic", null: false
    t.text "description", null: false
    t.integer "type_ev", null: false
    t.datetime "date", null: false
    t.integer "frequence", null: false
    t.datetime "end_time", null: false
    t.integer "state", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_group_id"], name: "index_events_on_research_group_id"
  end

  create_table "events_photos", id: false, force: :cascade do |t|
    t.integer "photo_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_events_photos_on_event_id"
    t.index ["photo_id"], name: "index_events_photos_on_photo_id"
  end

  create_table "events_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.index ["event_id"], name: "index_events_users_on_event_id"
    t.index ["user_id"], name: "index_events_users_on_user_id"
  end

  create_table "faculties", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.text "link", limit: 300
    t.string "imageable_type"
    t.integer "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id"
  end

  create_table "publications", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.date "date", null: false
    t.text "abstract", null: false
    t.string "url", limit: 300, null: false
    t.string "brief_description", limit: 500, null: false
    t.string "file_name", limit: 300
    t.integer "type_pub", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "publications_research_groups", id: false, force: :cascade do |t|
    t.integer "research_group_id"
    t.integer "publication_id"
    t.index ["publication_id"], name: "index_publications_research_groups_on_publication_id"
    t.index ["research_group_id"], name: "index_publications_research_groups_on_research_group_id"
  end

  create_table "publications_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "publication_id"
    t.index ["publication_id"], name: "index_publications_users_on_publication_id"
    t.index ["user_id"], name: "index_publications_users_on_user_id"
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
    t.string "url", limit: 300
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_research_groups_on_photo_id"
  end

  create_table "research_groups_subjects", id: false, force: :cascade do |t|
    t.integer "research_group_id"
    t.integer "research_subject_id"
    t.index ["research_group_id"], name: "index_research_groups_subjects_on_research_group_id"
    t.index ["research_subject_id"], name: "index_research_groups_subjects_on_research_subject_id"
  end

  create_table "research_subjects", force: :cascade do |t|
    t.string "name", limit: 200
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "research_subjects_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "research_subject_id"
    t.index ["research_subject_id"], name: "index_research_subjects_users_on_research_subject_id"
    t.index ["user_id"], name: "index_research_subjects_users_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "schedules_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "schedule_id"
    t.index ["schedule_id"], name: "index_schedules_users_on_schedule_id"
    t.index ["user_id"], name: "index_schedules_users_on_user_id"
  end

  create_table "user_research_groups", id: false, force: :cascade do |t|
    t.date "joining_date", null: false
    t.date "end_joining_date", null: false
    t.integer "state", default: 0, null: false
    t.integer "type_urg", default: 0, null: false
    t.integer "hours_per_week", default: 0, null: false
    t.integer "user_id"
    t.integer "research_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["research_group_id"], name: "index_user_research_groups_on_research_group_id"
    t.index ["user_id"], name: "index_user_research_groups_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "lastname", limit: 100, null: false
    t.string "username", limit: 40, null: false
    t.string "email", limit: 100, null: false
    t.text "professional_profile", limit: 5000, null: false
    t.integer "type_u", null: false
    t.string "phone", limit: 20
    t.string "office", limit: 20
    t.string "cvlac_link", limit: 200
    t.integer "career_id"
    t.integer "photo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["career_id"], name: "index_users_on_career_id"
    t.index ["photo_id"], name: "index_users_on_photo_id"
  end

end
