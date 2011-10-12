class Department < ReadOnlyModel
  include HasUsageReports

  set_table_name "departments"
  set_primary_key "id"

  has_and_belongs_to_many :colleges, 
                          :join_table => "department_colleges",
                          :foreign_key => :dept_id,
                          :association_foreign_key => :college_id,
                          :class_name => 'College'

  has_many :people, :foreign_key => "dept_id"

  USAGE_REPORT_FIELDS = "departments.id, departments.name, use_count"
  USAGE_REPORT_DEMOGRAPHICS_JOINS = "LEFT JOIN department_colleges on department_colleges.dept_id = departments.id
                                     LEFT JOIN colleges on colleges.id = department_colleges.college_id"

  def self.join_executables_sql(report_options)
    "INNER JOIN persons on persons.dept_id = departments.id
     INNER JOIN users on users.person_id = persons.id
     INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = users.username
     INNER JOIN executable ex on e.feature = ex.identifier"
  end


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
