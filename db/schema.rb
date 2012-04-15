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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120407195105) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "payments", :force => true do |t|
    t.integer  "reminder_id"
    t.date     "pay_date"
    t.integer  "amount",      :limit => 8
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "reminders", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.date     "due_date"
    t.integer  "alert_threshold"
    t.boolean  "email"
    t.boolean  "sms"
    t.boolean  "facebook"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "alert_type"
  end

  create_table "tokens", :force => true do |t|
    t.integer  "user_id"
    t.string   "activation_tokn"
    t.boolean  "user_active",     :default => false
    t.string   "phone_tokn"
    t.string   "phone_no"
    t.boolean  "phone_active",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password"
    t.string   "salt"
    t.boolean  "admin",              :default => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "confirmation_token"
    t.boolean  "confirmed",          :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
