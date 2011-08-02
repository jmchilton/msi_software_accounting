class CreateColleges < ActiveRecord::Migration
  def self.up
    create_table("people.colleges", :primary_key => "id") do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table "people.colleges"
  end
end
