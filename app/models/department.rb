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
    join_groups_str = "" # By default no need to join groups
    if report_options[:exclude_employees]
      join_groups_str = "INNER JOIN groups ig on (ig.gid = users.gid and ig.name not in #{Group::EMPLOYEE_GROUPS})"
    end
    if report_options[:data_source] == :collectl
      join_users_str = "INNER JOIN (#{CollectlExecution.valid_executions(report_options).to_sql}) e ON e.user_id = users.id
                        INNER JOIN collectl_executables ex on e.collectl_executable_id = ex.id"
    elsif report_options[:data_source] == :flexlm
      join_users_str = "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = users.username
                        INNER JOIN executable ex on e.feature = ex.identifier"
    elsif report_options[:data_source] == :module
      join_users_str = "INNER JOIN (#{ModuleLoad.valid_events(report_options).to_sql}) e ON e.username = users.username
                        INNER JOIN modules ex on ex.name = e.name"
    else
      raise ArgumentError
    end
    "INNER JOIN persons on persons.dept_id = departments.id
     INNER JOIN users on users.person_id = persons.id  #{join_groups_str}
     #{join_users_str}"
  end


  def self.persons_to_executables_joins(report_options, departments_alias = "departments")
    "INNER JOIN persons person ON person.dept_id = #{departments_alias}.id #{User.user_to_executables_joins "person_id = person.id", report_options}"
  end

  def self.resources(report_options = {})
    resource_id_column = report_options[:data_source] == :flexlm ? "rid" : "resource_id"
    relation = select("departments.id, ex.#{resource_id_column} as rid").
                 joins(Department.persons_to_executables_joins(report_options)).
                 group("departments.id, ex.#{resource_id_column}")
    relation
  end


  def self.report(report_options = {})
    relation = select("departments.id, departments.name, #{Purchase::REPORT_SELECT_FIELDS}").
               joins("inner join (#{resources(report_options).to_aliased_sql('ic')}) dr on departments.id = dr.id
                      #{Purchase.summary_left_join("dr.rid")}").
               order("departments.name ASC").
               group("departments.id, departments.name")
    relation
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/department/#{id}/view"
  end

end
