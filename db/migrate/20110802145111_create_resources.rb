class CreateResources < ActiveRecord::Migration
  def self.up
    create_table ("swacct.resources", :primary_key => "rid") do |t|
      t.integer :rid
      t.string :name
      t.string :short_name
      t.string :description
      t.string :calendar_desc
      t.string :documentation
      t.string :module

      t.timestamps
    end
  end

  def self.down
    drop_table "swacct.resources"
  end
end
