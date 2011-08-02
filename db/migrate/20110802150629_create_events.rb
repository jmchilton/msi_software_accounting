class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table("swacct.event", :primary_key => :evid) do |t|
      t.integer :evid
      t.datetime :ev_date
      t.string :vendor
      t.string :feature
      t.string :user
      t.string :ugrp
      t.string :host
      t.string :operation
      t.string :comment

      t.timestamps
    end
  end

  def self.down
    drop_table "swacct.event"
  end
end
