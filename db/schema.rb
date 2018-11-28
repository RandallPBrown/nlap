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

ActiveRecord::Schema.define(version: 20181127220750) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", force: :cascade do |t|
    t.string "fname"
    t.string "lname"
    t.date "hire"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dept"
    t.bigint "department_id"
    t.index ["department_id"], name: "index_agents_on_department_id"
  end

  create_table "agents_departments", id: false, force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.bigint "department_id", null: false
  end

  create_table "create_join_table_agent_departments", force: :cascade do |t|
    t.string "agent"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "department_id"
    t.bigint "occurrence_id"
    t.date "edate"
    t.text "edesc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_entries_on_agent_id"
    t.index ["department_id"], name: "index_entries_on_department_id"
    t.index ["occurrence_id"], name: "index_entries_on_occurrence_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.float "ovalue"
    t.date "odate"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.date "sdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "writeups", force: :cascade do |t|
    t.string "type"
    t.date "wdate"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agents", "departments"
  add_foreign_key "entries", "agents"
  add_foreign_key "entries", "departments"
  add_foreign_key "entries", "occurrences"
end
