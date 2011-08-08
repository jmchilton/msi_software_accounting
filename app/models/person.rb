class Person < ActiveRecord::Base
  set_table_name "persons"
  set_primary_key "id"

  belongs_to :department, :foreign_key => "dept_id"

  has_many :users, :foreign_key => "person_id"
end
