class AddExecutableBelongsToResource < ActiveRecord::Migration
  def self.up
    change_table :executable do |t| 
      t.integer :rid
    end
  end

  def self.down
    remove_column :executable, :rid
  end
end
