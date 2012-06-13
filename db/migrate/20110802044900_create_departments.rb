class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table("departments", :primary_key => "id") do |t|
      t.integer :id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table("departments")
  end
end
