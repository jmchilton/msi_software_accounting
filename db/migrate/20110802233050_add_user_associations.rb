class AddUserAssociations < ActiveRecord::Migration
  def self.up
    change_table :users do |t| 
      t.integer :person_id
      t.integer :gid
    end
  end

  def self.down
    remove_column :users, :person_id
    remove_column :users, :gid
  end
end
