class FixPrimaryKeys < ActiveRecord::Migration
  def self.up
    drop_table "event"

    create_table "event", :primary_key => :evid, :force => true do |t|
      t.integer  "evid"
      t.datetime "ev_date"
      t.string   "vendor"
      t.string   "feature"
      t.string   "unam"
      t.string   "host"
      t.string   "operation"
      t.string   "comment"
      t.integer  "rid"
    end

    drop_table "purchase" 

    create_table "purchase", :primary_key => :pid, :force => true do |t|
      t.integer  "rid"
      t.string   "os"
      t.integer  "flexlm"
      t.integer  "name"
      t.integer  "fy10"
      t.integer  "fy11"
      t.integer  "fy12"
      t.integer  "fy13"
    end

  end

  def self.down
    drop_table "event"

    create_table "event", :id => false, :force => true do |t|
      t.integer  "evid"
      t.datetime "ev_date"
      t.string   "vendor"
      t.string   "feature"
      t.string   "unam"
      t.string   "ugrp"
      t.string   "host"
      t.string   "operation"
      t.string   "comment"
      t.integer  "rid"
    end  

    drop_table "purchase"

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
    end

  end
end
