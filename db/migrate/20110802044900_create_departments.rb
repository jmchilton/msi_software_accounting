class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table("people.departments", :primary_key => "id") do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table("people.departments")
  end
end
