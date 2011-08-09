class FixesWithLegacy < ActiveRecord::Migration
  def self.up
    rename_column :event, :user, :unam
    rename_column :resources, :rid, :id
  end

  def self.down
    rename_column :event, :unam, :user
    rename_column :resources, :id, :rid
  end
end
