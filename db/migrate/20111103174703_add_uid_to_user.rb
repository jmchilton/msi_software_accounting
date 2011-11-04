class AddUidToUser < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :uid
    end
  end

  def self.down
    remove_column :users, :uid
  end
end
