class College < ReadOnlyModel
  set_table_name "colleges"
  set_primary_key "id"

  has_and_belongs_to_many :departments,
                          :join_table => "department_colleges",
                          :foreign_key => :college_id,
                          :association_foreign_key => :dept_id,
                          :class_name => 'Department'

  scope :report, select("colleges.id, colleges.name").
                  where("event.operation = 'OUT'").
                  joins(:departments => { :people => {:users => { :events => :resource} } }).
                  order("colleges.name ASC").
                  group("colleges.name")

end
