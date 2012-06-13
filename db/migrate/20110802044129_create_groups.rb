class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table("groups", :primary_key => :gid) do |t|
      t.integer :gid
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table "groups"
  end
end
