class Department < ReadOnlyModel
  set_table_name "departments"
  set_primary_key "id"

  has_and_belongs_to_many :colleges, 
                          :join_table => "department_colleges",
                          :foreign_key => :dept_id,
                          :association_foreign_key => :college_id,
                          :class_name => 'College'

  has_many :people, :foreign_key => "dept_id"

  def self.persons_to_executables_joins(report_options, departments_alias = "departments")
    "INNER JOIN persons person ON person.dept_id = #{departments_alias}.id #{User.user_to_executables_joins "person_id = person.id", report_options}"
  end

  def self.resources(report_options = {})
    select("departments.id, ex.rid").
      joins(Department.persons_to_executables_joins(report_options)).
      group("departments.id, ex.rid")
  end


  def self.report(report_options = {})
    relation = select("departments.name, #{Purchase::REPORT_SELECT_FIELDS}").
               joins("left join (#{resources(report_options).to_aliased_sql('ic')}) dr on departments.id = dr.id
                      #{Purchase.summary_left_join("dr.rid")}").
               order("departments.name ASC").
               group("departments.name")
    relation
  end

end
