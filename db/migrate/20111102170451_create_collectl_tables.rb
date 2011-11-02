class CreateCollectlTables < ActiveRecord::Migration
  def self.up
    create_table :raw_collectl_executions, :name => "raw_collectl_executions", :primary_key => :id  do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :pid
      t.integer :uid
      t.string :executable
      t.string :host
    end

    create_table :collectl_executions, :name => "collectl_executions", :primary_key => :id  do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :pid
      t.string :host

      t.integer :executable_id, :references => [:executable, :exid]
      t.integer :user_id, :references => [:users, :id]
    end

  end

  def self.down
    drop_table :raw_collectl_executions
    drop_table :collectl_executions
  end

end

