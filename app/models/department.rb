class Department < ActiveRecord::Base
  set_table_name "departments"
  set_primary_key "id"

  has_and_belongs_to_many :colleges, 
                          :join_table => "department_colleges",
                          :foreign_key => :dept_id,
                          :association_foreign_key => :college_id,
                          :class_name => 'College'

  has_many :people, :foreign_key => "dept_id"
end
