class CreateCollectlExecutable < ActiveRecord::Migration
  def self.up
    create_table :collectl_executables, :primary_key => :id  do |t|
      t.string :name

      t.integer :resource_id, :references => [:resource, :id]
    end

    remove_column :collectl_executions, :executable_id

    change_table :collectl_executions do |t|
      t.integer :collectl_executable_id, :references => [:collectl_executable, :id]
    end

  end

  def self.down
    drop_table :collectl_executables

    change_table :collectl_executions do |t|
      t.integer :executable_id, :references => [:executable, :exid]
    end

    remove_column :collectl_executions, :collectl_executable_id
  end
end
