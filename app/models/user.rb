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

  def self.join_executables_sql(report_options)
    "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = users.username
     INNER JOIN executable ex on e.feature = ex.identifier"
  end


  def self.user_to_executables_joins(join_users_on, report_options = {})
    "INNER JOIN users u ON u.#{join_users_on}
     INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = u.username
     INNER JOIN executable ex on e.feature = ex.identifier"
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/user/#{id}/view"
  end

end
