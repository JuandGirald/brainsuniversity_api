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

ActiveRecord::Schema.define(version: 20170615010942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.integer  "teacher_id"
    t.string   "morning",    default: [],              array: true
    t.string   "afternoon",  default: [],              array: true
    t.string   "evening",    default: [],              array: true
    t.string   "night",      default: [],              array: true
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "bank_informations", force: :cascade do |t|
    t.integer  "teacher_id"
    t.bigint   "owner_id"
    t.string   "account_number"
    t.string   "bank_name"
    t.string   "account_type"
    t.string   "owner_name"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["teacher_id"], name: "index_bank_informations_on_teacher_id", using: :btree
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["recipient_id"], name: "index_chats_on_recipient_id", using: :btree
    t.index ["sender_id"], name: "index_chats_on_sender_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "chat_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id", using: :btree
    t.index ["user_id"], name: "index_messages_on_user_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "schedule_id"
    t.string   "number"
    t.decimal  "total"
    t.string   "hour"
    t.string   "title"
    t.text     "description"
    t.datetime "completed_at"
    t.string   "currency"
    t.string   "status",       default: "3", null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.date     "dob"
    t.string   "phone"
    t.string   "address"
    t.string   "gender"
    t.string   "city"
    t.string   "country"
    t.string   "university"
    t.string   "level"
    t.text     "about"
    t.integer  "rate"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "teacher_id"
    t.integer  "student_id"
    t.index ["student_id"], name: "index_profiles_on_student_id", using: :btree
    t.index ["teacher_id"], name: "index_profiles_on_teacher_id", using: :btree
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "schedule_id"
    t.string   "session_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "student_token", limit: 10000
    t.string   "teacher_token", limit: 10000
    t.index ["schedule_id"], name: "index_rooms_on_schedule_id", using: :btree
  end

  create_table "schedules", force: :cascade do |t|
    t.string   "teacher_id"
    t.string   "student_id"
    t.string   "duration"
    t.string   "modality"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
    t.index ["student_id"], name: "index_schedules_on_student_id", using: :btree
    t.index ["teacher_id"], name: "index_schedules_on_teacher_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                       null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
    t.string   "role",                        default: "3",   null: false
    t.string   "type"
    t.string   "password_digest"
    t.string   "activation_state"
    t.string   "activation_token"
    t.datetime "activation_token_expires_at"
    t.string   "activation_digest"
    t.boolean  "activated",                   default: false
    t.datetime "activated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
    t.text     "subjects",                    default: [],                 array: true
    t.index ["activation_token"], name: "index_users_on_activation_token", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
  add_foreign_key "profiles", "users"
end
