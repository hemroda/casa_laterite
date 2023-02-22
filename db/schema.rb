# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_02_25_212154) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.integer "locale", default: 0
    t.boolean "confirmed", default: false
    t.boolean "public_profile", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_accounts_on_unlock_token", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "line_one"
    t.string "line_two"
    t.string "phone_number"
    t.string "city"
    t.string "zip_code"
    t.string "country"
    t.text "additional_information"
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "name", null: false
    t.float "amount", default: 0.0, null: false
    t.text "description"
    t.integer "contribution_type"
    t.bigint "account_id"
    t.string "contributable_type", null: false
    t.bigint "contributable_id", null: false
    t.string "validated_by_type"
    t.bigint "validated_by_id"
    t.string "cancelled_by_type"
    t.bigint "cancelled_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["account_id"], name: "index_contributions_on_account_id"
    t.index ["cancelled_by_type", "cancelled_by_id"], name: "index_contributions_on_cancelled_by"
    t.index ["contributable_type", "contributable_id"], name: "index_contributions_on_contributable"
    t.index ["discarded_at"], name: "index_contributions_on_discarded_at"
    t.index ["validated_by_type", "validated_by_id"], name: "index_contributions_on_validated_by"
  end

  create_table "decks", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", null: false
    t.integer "status", default: 0
    t.integer "access_type", default: 0
    t.datetime "reviewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_decks_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time"
    t.string "location"
    t.integer "event_type", default: 0
    t.string "color"
    t.boolean "shared"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_events_on_discarded_at"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "managers", force: :cascade do |t|
    t.bigint "user_id"
    t.string "manageable_type", null: false
    t.bigint "manageable_id", null: false
    t.string "assigned_by_type"
    t.bigint "assigned_by_id"
    t.string "unassigned_by_type"
    t.bigint "unassigned_by_id"
    t.boolean "lead_manager", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_by_type", "assigned_by_id"], name: "index_managers_on_assigned_by"
    t.index ["manageable_type", "manageable_id"], name: "index_managers_on_manageable"
    t.index ["unassigned_by_type", "unassigned_by_id"], name: "index_managers_on_unassigned_by"
    t.index ["user_id"], name: "index_managers_on_user_id"
  end

  create_table "milestones", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_milestones_on_project_id"
  end

  create_table "ownerships", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "property_id"
    t.string "deallocated_by_type"
    t.bigint "deallocated_by_id"
    t.string "allocated_by_type"
    t.bigint "allocated_by_id"
    t.integer "old_owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_ownerships_on_account_id"
    t.index ["allocated_by_type", "allocated_by_id"], name: "index_ownerships_on_allocated_by"
    t.index ["deallocated_by_type", "deallocated_by_id"], name: "index_ownerships_on_deallocated_by"
    t.index ["property_id"], name: "index_ownerships_on_property_id"
  end

  create_table "payments", force: :cascade do |t|
    t.float "amount", default: 0.0, null: false
    t.string "name", null: false
    t.text "message"
    t.integer "status", default: 0
    t.datetime "due_date"
    t.string "payable_type", null: false
    t.bigint "payable_id", null: false
    t.string "created_by_type", null: false
    t.bigint "created_by_id", null: false
    t.string "canceled_by_type"
    t.bigint "canceled_by_id"
    t.string "validated_by_type"
    t.bigint "validated_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["canceled_by_type", "canceled_by_id"], name: "index_payments_on_canceled_by"
    t.index ["created_by_type", "created_by_id"], name: "index_payments_on_created_by"
    t.index ["discarded_at"], name: "index_payments_on_discarded_at"
    t.index ["payable_type", "payable_id"], name: "index_payments_on_payable"
    t.index ["validated_by_type", "validated_by_id"], name: "index_payments_on_validated_by"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "user_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_posts_on_account_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "project_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "projectable_type", null: false
    t.bigint "projectable_id", null: false
    t.bigint "project_type_id", null: false
    t.string "name"
    t.text "description"
    t.integer "status", default: 0
    t.integer "visibility_type", default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "completed_at"
    t.boolean "tracked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_type_id"], name: "index_projects_on_project_type_id"
    t.index ["projectable_type", "projectable_id"], name: "index_projects_on_projectable"
  end

  create_table "properties", force: :cascade do |t|
    t.bigint "property_type_id", null: false
    t.bigint "building_id"
    t.string "name", null: false
    t.text "description"
    t.integer "rooms"
    t.integer "bathrooms"
    t.datetime "year_built"
    t.integer "square_feet"
    t.string "headline"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_properties_on_building_id"
    t.index ["property_type_id"], name: "index_properties_on_property_type_id"
  end

  create_table "property_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "deck_id", null: false
    t.integer "proficiency_level", default: 0
    t.datetime "reviewed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_questions_on_deck_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "milestone_id"
    t.bigint "user_id"
    t.string "name"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "completed_at"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["milestone_id"], name: "index_tasks_on_milestone_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "timers", force: :cascade do |t|
    t.bigint "task_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_timers_on_task_id"
  end

  create_table "todo_items", force: :cascade do |t|
    t.bigint "task_id"
    t.string "title", null: false
    t.boolean "completed", default: false
    t.datetime "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_todo_items_on_task_id"
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
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.integer "role", default: 0
    t.integer "locale", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "contributions", "accounts"
  add_foreign_key "decks", "users"
  add_foreign_key "events", "users"
  add_foreign_key "managers", "users"
  add_foreign_key "milestones", "projects"
  add_foreign_key "ownerships", "accounts"
  add_foreign_key "ownerships", "properties"
  add_foreign_key "posts", "accounts"
  add_foreign_key "posts", "users"
  add_foreign_key "projects", "project_types"
  add_foreign_key "properties", "properties", column: "building_id"
  add_foreign_key "properties", "property_types"
  add_foreign_key "questions", "decks"
  add_foreign_key "tasks", "milestones"
  add_foreign_key "tasks", "projects"
  add_foreign_key "tasks", "users"
  add_foreign_key "timers", "tasks"
  add_foreign_key "todo_items", "tasks"
end
