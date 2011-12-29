class AddResourceIdToModule < ActiveRecord::Migration
  def self.up
    change_table :modules do |t|
      t.integer :resource_id
    end
  end

  def self.down
    remove_column :modules, :resource_id
  end
end
