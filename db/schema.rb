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

ActiveRecord::Schema.define(version: 20190711190416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agent_stats", force: :cascade do |t|
    t.string "extension"
    t.string "name"
    t.date "date"
    t.time "shift"
    t.time "total_login"
    t.time "total_break"
    t.time "net_login"
    t.time "requested_worktime"
    t.float "availability"
    t.float "occupancy"
    t.integer "queue_calls"
    t.time "queue_talk"
    t.integer "direct_calls"
    t.time "direct_talk"
    t.integer "outbound_calls"
    t.time "outbound_talk"
    t.integer "callback_calls"
    t.time "callback_talk"
    t.integer "deleted"
    t.integer "un_ans"
    t.integer "picked"
    t.integer "recover"
    t.integer "power_dial"
    t.time "acw"
    t.time "wrapup_time"
    t.integer "total_calls"
    t.time "total_talk"
    t.time "aht"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "abnd"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_agent_stats_on_user_id"
  end

  create_table "agents", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dept"
    t.bigint "department_id"
    t.bigint "user_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_agents_on_deleted_at"
    t.index ["department_id"], name: "index_agents_on_department_id"
    t.index ["user_id"], name: "index_agents_on_user_id"
  end

  create_table "agents_departments", id: false, force: :cascade do |t|
    t.bigint "agent_id", null: false
    t.bigint "department_id", null: false
  end

  create_table "buying_groups", force: :cascade do |t|
    t.string "bgname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_categories_on_language_id"
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "topic"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.text "chtml"
    t.text "ccss"
    t.text "cjavascript"
    t.text "cror"
    t.text "cinfo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_components_on_category_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "priority"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.bigint "dealer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dealer_id"], name: "index_contacts_on_dealer_id"
  end

  create_table "create_join_table_agent_departments", force: :cascade do |t|
    t.string "agent"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "daps", force: :cascade do |t|
    t.string "description"
    t.date "ddate"
    t.bigint "user_id"
    t.bigint "writeup_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "wunature_id"
    t.index ["user_id"], name: "index_daps_on_user_id"
    t.index ["writeup_id"], name: "index_daps_on_writeup_id"
    t.index ["wunature_id"], name: "index_daps_on_wunature_id"
  end

  create_table "dealers", force: :cascade do |t|
    t.bigint "buying_group_id"
    t.boolean "appliance"
    t.boolean "electronic"
    t.boolean "furniture"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "instructions"
    t.text "body_prefix"
    t.text "body_suffix"
    t.index ["buying_group_id"], name: "index_dealers_on_buying_group_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "team_id"
    t.index ["team_id"], name: "index_departments_on_team_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "occurrence_id"
    t.bigint "agent_id"
    t.string "edesc"
    t.date "edate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "dept"
    t.index ["agent_id"], name: "index_entries_on_agent_id"
    t.index ["occurrence_id"], name: "index_entries_on_occurrence_id"
  end

  create_table "err_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "department_id"
    t.date "errdate"
    t.bigint "err_name_id"
    t.text "errdesc"
    t.bigint "err_status_id"
    t.string "errsubmitby"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "approved_by"
    t.text "err_notes"
    t.float "err_cost"
    t.string "serviceorder"
    t.index ["department_id"], name: "index_err_logs_on_department_id"
    t.index ["err_name_id"], name: "index_err_logs_on_err_name_id"
    t.index ["err_status_id"], name: "index_err_logs_on_err_status_id"
    t.index ["user_id"], name: "index_err_logs_on_user_id"
  end

  create_table "err_names", force: :cascade do |t|
    t.string "errname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "err_statuses", force: :cascade do |t|
    t.string "statusname"
    t.integer "errvalue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "chatroom_id"
    t.bigint "user_id"
    t.string "subject"
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "mfg_parts", force: :cascade do |t|
    t.string "part_name"
    t.string "part_number"
    t.bigint "manufacturer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer_id"], name: "index_mfg_parts_on_manufacturer_id"
  end

  create_table "models", force: :cascade do |t|
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
    t.index ["email"], name: "index_models_on_email", unique: true
    t.index ["reset_password_token"], name: "index_models_on_reset_password_token", unique: true
  end

  create_table "network_maps", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "servicerstatus"
    t.string "self_servicing"
    t.string "provider_number"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "fax"
    t.string "contracted"
    t.string "sealed_system"
    t.string "rating"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "occurrences", force: :cascade do |t|
    t.float "ovalue"
    t.date "odate"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "parts", force: :cascade do |t|
    t.string "part_number"
    t.string "part_name"
    t.text "part_description"
    t.bigint "product_id"
    t.bigint "buying_group_id"
    t.date "dop"
    t.string "covered"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "submitted_by"
    t.string "approved_by"
    t.string "source"
    t.time "read_at"
    t.text "note"
    t.string "serviceorder"
    t.index ["buying_group_id"], name: "index_parts_on_buying_group_id"
    t.index ["product_id"], name: "index_parts_on_product_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "products", force: :cascade do |t|
    t.string "pname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipients", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_recipients_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "procedure_id"
    t.string "goal"
    t.text "description"
    t.string "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item"
    t.index ["procedure_id"], name: "index_sections_on_procedure_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "group_id"
    t.index ["group_id"], name: "index_teams_on_group_id"
  end

  create_table "tools", force: :cascade do |t|
    t.text "receipt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "serviceorder"
    t.string "caller_name"
    t.string "service_provider"
    t.string "model_number"
    t.string "serial_number"
    t.text "failure_cause"
    t.string "warranty_link"
    t.string "sku"
    t.float "opp"
    t.float "ppc"
    t.float "lol"
    t.string "distributor"
    t.float "total_parts"
    t.float "total_labor"
    t.float "total_tax"
    t.float "total_mileage"
    t.float "total_misc"
    t.float "total_deductible"
    t.float "total_estimate"
    t.string "approved"
    t.float "diagnostic"
    t.string "username"
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
    t.boolean "admin"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "role"
    t.bigint "department_id"
    t.bigint "agent_id"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "deleted_at"
    t.string "extension"
    t.index ["agent_id"], name: "index_users_on_agent_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "writeups", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wunatures", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "agent_stats", "users"
  add_foreign_key "agents", "departments"
  add_foreign_key "agents", "users"
  add_foreign_key "categories", "languages"
  add_foreign_key "components", "categories"
  add_foreign_key "contacts", "dealers"
  add_foreign_key "daps", "users"
  add_foreign_key "daps", "writeups"
  add_foreign_key "daps", "wunatures"
  add_foreign_key "dealers", "buying_groups"
  add_foreign_key "departments", "teams"
  add_foreign_key "err_logs", "departments"
  add_foreign_key "err_logs", "err_names"
  add_foreign_key "err_logs", "err_statuses"
  add_foreign_key "err_logs", "users"
  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
  add_foreign_key "mfg_parts", "manufacturers"
  add_foreign_key "parts", "buying_groups"
  add_foreign_key "parts", "products"
  add_foreign_key "recipients", "users"
  add_foreign_key "sections", "procedures"
  add_foreign_key "teams", "groups"
  add_foreign_key "users", "agents"
  add_foreign_key "users", "departments"
end
