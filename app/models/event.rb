class Event < ReadOnlyModel
  set_table_name "event"
  set_primary_key "evid"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'
  belongs_to :process_user, :class_name => 'User', :foreign_key => "unam", :primary_key => "username"

  def self.valid_events(report_options = {})
    relation = where("OPERATION = 'OUT'")
    DateOptions.handle_date_options(relation, 'EV_DATE', report_options)
  end

  # TODO: Move


  def self.sql_user_list(list)
    sanitize_sql_array(["(#{(list.map{|x| "?"}).join(",")})"] + list)
  end

  def self.to_demographics_joins(report_options = {})
    group_join_condition = "users.gid = groups.gid"
    users_join_condition = "users.username = e.unam"
    unless report_options[:limit_users].nil?
      users_join_condition = "(#{users_join_condition} and users.username in #{sql_user_list(report_options[:limit_users])} )"
    end
    if report_options[:exclude_employees]
      group_join_condition = "(#{group_join_condition} and groups.name not in #{Group::EMPLOYEE_GROUPS})"
    end
    "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e on e.feature = executable.identifier
     INNER JOIN users on #{users_join_condition}
     INNER JOIN groups on #{group_join_condition} "
  end

end
