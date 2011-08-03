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

ActiveRecord::Schema.define(:version => 20110803190500) do

  create_table "colleges", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "department_colleges", :id => false, :force => true do |t|
    t.integer "dept_id"
    t.integer "college_id"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event", :primary_key => "evid", :force => true do |t|
    t.datetime "ev_date"
    t.string   "vendor"
    t.string   "feature"
    t.string   "user"
    t.string   "ugrp"
    t.string   "host"
    t.string   "operation"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rid"
  end

  create_table "executable", :primary_key => "exid", :force => true do |t|
    t.integer  "identifier_type"
    t.string   "identifier"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rid"
  end

  create_table "groups", :primary_key => "gid", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "persons", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "active"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dept_id"
  end

  create_table "purchase", :id => false, :force => true do |t|
    t.integer  "pid"
    t.integer  "rid"
    t.string   "os"
    t.integer  "flexlm"
    t.integer  "name"
    t.integer  "fy10"
    t.integer  "fy11"
    t.integer  "fy12"
    t.integer  "fy13"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resources", :primary_key => "rid", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "description"
    t.string   "calendar_desc"
    t.string   "documentation"
    t.string   "module"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
    t.integer  "gid"
  end

end
