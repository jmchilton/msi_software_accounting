class AddDepartmentColegeJoinTable < ActiveRecord::Migration
  def self.up
    create_table :department_colleges, :id => false do |t|
      t.integer :dept_id
      t.integer :college_id
    end
  end

  def self.down
    drop_table :department_colleges
  end
end
