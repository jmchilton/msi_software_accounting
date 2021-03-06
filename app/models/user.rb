require 'static_data'

class User < ReadOnlyModel
  include HasUsageReports

  set_table_name "users"
  set_primary_key "id"

  belongs_to :group, :foreign_key => "gid"
  belongs_to :person, :foreign_key => "person_id"

  has_many :events, :foreign_key => "unam", :primary_key => "username"

  USAGE_REPORT_FIELDS = "users.id, users.username as username, groups.name as group_name, persons.first_name, persons.last_name, persons.email, colleges.name as college_name, use_count"
  USAGE_REPORT_DEMOGRAPHICS_JOINS = "LEFT JOIN persons on users.person_id = persons.id
                                     LEFT JOIN groups on groups.gid = users.gid
                                     LEFT JOIN departments on persons.dept_id = departments.id
                                     LEFT JOIN department_colleges on department_colleges.dept_id = departments.id
                                     LEFT JOIN colleges on colleges.id = department_colleges.college_id"

  def self.index
    select("users.id, users.username, persons.first_name, persons.last_name, persons.email, groups.name as group_name").
      joins("LEFT JOIN persons on users.person_id = persons.id LEFT JOIN groups on groups.gid = users.gid")
  end

  def self.join_executables_sql(report_options)
    join_executables(report_options, "users", join_groups_str(report_options))
  end

  def self.join_groups_str(report_options, users_alias = "users")
    join_groups_str = "" # By default no need to join groups
    if report_options[:exclude_employees]
      join_groups_str = "INNER JOIN groups ig on (ig.gid = #{users_alias}.gid and ig.name not in #{Group::EMPLOYEE_GROUPS})"
    end
    join_groups_str
  end


  def name  # To provide common interface with department/college/group
    username
  end


  def self.user_to_executables_joins(join_users_on, report_options = {})
    "INNER JOIN users u ON u.#{join_users_on} #{join_groups_str(report_options, 'u')} #{join_executables(report_options, "u")}"
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/user/#{id}/view"
  end

  private

  def self.join_executables(report_options, users_alias, on_str = "")
     data_source = report_options[:data_source]
     if data_source == :collectl
      "INNER JOIN (#{CollectlExecution.valid_executions(report_options).to_sql}) e ON e.user_id = #{users_alias}.id #{on_str}
       INNER JOIN collectl_executables ex on e.collectl_executable_id = ex.id"
    elsif data_source == :flexlm
      "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = #{users_alias}.username #{on_str}
       INNER JOIN executable ex on e.feature = ex.identifier"
    elsif data_source == :module
       "INNER JOIN (#{ModuleLoad.valid_events(report_options).to_sql}) e on e.username = #{users_alias}.username #{on_str}
        INNER JOIN modules ex on e.name = ex.name"
    else
      raise ArgumentError
    end
  end

end
