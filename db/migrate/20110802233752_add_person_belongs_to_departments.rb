class AddPersonBelongsToDepartments < ActiveRecord::Migration
  def self.up
    change_table :persons do |t|
      t.integer :dept_id
    end
  end

  def self.down
    remove_column :persons, :dept_id
  end
end
