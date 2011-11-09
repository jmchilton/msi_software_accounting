class CollectlExecution < ActiveRecord::Base
  set_table_name "collectl_executions"

  belongs_to :user
  belongs_to :collectl_executable

  def self.valid_executions(report_options = {})
    relation = where("1=1")
    DateOptions.handle_date_options(relation, 'START_TIME', report_options)
  end

  def self.index_raw_records(executable_id = nil)
    for_executables = ""
    unless executable_id.blank?
      for_executables = "and ex.id = '#{executable_id}'"
    end
    connection.execute "insert into collectl_executions (ID, START_TIME, END_TIME, HOST, PID, USER_ID, COLLECTL_EXECUTABLE_ID)
                          select rce.ID, rce.START_TIME, rce.END_TIME, rce.HOST, rce.PID, u.id, ex.id
                            from raw_collectl_executions rce
                              inner join users u on u.uid = rce.uid
                              inner join collectl_executables ex on ex.name = substr(rce.executable, -length(ex.name))
                          where 1 not in (select 1 from collectl_executions ce where ce.ID = rce.ID) #{for_executables}"
    connection.execute "update collectl_executions
                        set START_TIME = (select rce.START_TIME from raw_collectl_executions rce where rce.id = collectl_executions.id),
                            END_TIME   = (select rce.END_TIME   from raw_collectl_executions rce where rce.id = collectl_executions.id)"
  end

  # TODO: Refactor to combine shared code with Event.to_demographics_joins
  def self.to_demographics_joins(report_options = {})
    group_join_condition = "users.gid = groups.gid"
    users_join_condition = "users.id = e.user_id"
    unless report_options[:limit_users].nil?
      users_join_condition = "(#{users_join_condition} and users.username in #{Event.sql_user_list(report_options[:limit_users])} )"
    end
    if report_options[:exclude_employees]
      group_join_condition = "(#{group_join_condition} and groups.name not in #{Group::EMPLOYEE_GROUPS})"
    end
    "INNER JOIN (#{CollectlExecution.valid_executions(report_options).to_sql}) e on e.collectl_executable_id = collectl_executables.id
     INNER JOIN users on #{users_join_condition}
     INNER JOIN groups on #{group_join_condition} "
  end

end