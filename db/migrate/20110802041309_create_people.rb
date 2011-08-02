class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table("people.persons", :primary_key => :id)  do |t|
      t.integer :id
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :active
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table "people.persons"
  end
end
