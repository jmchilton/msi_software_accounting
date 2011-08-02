class AddEventBelongsToResource < ActiveRecord::Migration
  def self.up
    change_table :event do |t|
      t.integer :rid
    end
  end

  def self.down
    remove_column :event, :rid
  end
end
