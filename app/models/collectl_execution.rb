class CollectlExecution < ActiveRecord::Base
  set_table_name "collectl_executions"

  belongs_to :user
  belongs_to :collectl_executable

  def self.valid_executions(report_options = {})
    relation = where("1=1")
    DateOptions.handle_date_options(relation, 'START_TIME', report_options)
  end

  def self.index_raw_records(executable_id = nil)
    if executable_id.nil?
        connection.execute "insert into collectl_executions (ID, START_TIME, END_TIME, HOST, PID, USER_ID, COLLECTL_EXECUTABLE_ID)
                              select rce.ID, rce.START_TIME, rce.END_TIME, rce.HOST, rce.PID, u.id, ex.id
                              from raw_collectl_executions rce
                                inner join users u on u.uid = rce.uid
                                inner join collectl_executables ex on ex.name = substr(rce.executable, -length(ex.name))
                              where 1 not in (select 1 from collectl_executions ce where ce.ID = rce.ID)"
        connection.execute "update collectl_executions
                              set START_TIME = (select rce.START_TIME from raw_collectl_executions rce where rce.id = collectl_executions.id),
                                  END_TIME   = (select rce.END_TIME   from raw_collectl_executions rce where rce.id = collectl_executions.id)"
    else
      collectl_executable = CollectlExecutable.find(executable_id)
      name = collectl_executable.name
      sanitized_executable_id = sanitize_sql(executable_id)
      connection.execute "insert into collectl_executions (ID, START_TIME, END_TIME, HOST, PID, USER_ID, COLLECTL_EXECUTABLE_ID)
                            select rce.ID, rce.START_TIME, rce.END_TIME, rce.HOST, rce.PID, u.id, '#{sanitized_executable_id}'
                            from raw_collectl_executions rce
                              inner join users u on u.uid = rce.uid
                              left join collectl_executions ce on ce.id = rce.id
                            where substr(rce.executable, -#{name.length}) = '#{sanitize_sql(name)}' and ce.id is NULL"
      connection.execute "update collectl_executions
                            set START_TIME = (select rce.START_TIME from raw_collectl_executions rce where rce.id = collectl_executions.id),
                                END_TIME   = (select rce.END_TIME   from raw_collectl_executions rce where rce.id = collectl_executions.id)
                            where collectl_executable_id = '#{sanitized_executable_id}'"
    end

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

  # http://richtextblog.blogspot.com/2007/09/mysql-temporary-tables-and-rails.html
  def self.sample_for_executable(collectl_executable_id, report_options)
    begin
      connection.execute("DROP TABLE IF EXISTS interval_timestamps")
      connection.execute("CREATE TEMPORARY TABLE interval_timestamps(sample_date timestamp)")
      from = Time.parse report_options[:from]
      to = Time.parse report_options[:to]
      timestamps = (from..to).step(15 * 60).collect { |timestamp| "INSERT INTO interval_timestamps (sample_date) VALUES ('#{timestamp.to_formatted_s(:db)}');" }
      timestamps.each { |insert| connection.execute insert }

      sample_with = "max"
      if report_options[:sample_with] == "avg"
        sample_with = "avg"
      end

      sample_by = report_options[:sample]
      case sample_by
        when "date"
          group_by_date_expression = "DATE(timestamp)"
        else
          group_by_date_expression = "timestamp"
      end

      samples = connection.select_all "SELECT #{sample_with}(sample_count) as value, #{group_by_date_expression} as for_date
                                            FROM
                                             (SELECT it.sample_date as timestamp, count(*) as sample_count from collectl_executions ce inner join interval_timestamps it on it.sample_date between ce.start_time and ce.end_time
                                                WHERE ce.collectl_executable_id = '#{sanitize_sql(collectl_executable_id)}'
                                                GROUP BY it.sample_date)
                                                GROUP BY #{group_by_date_expression}"
      samples.collect { |row| row.symbolize_keys! }
    ensure
      # this drop is here to help keep the size of the data base down
      # between calls to this method
      connection.execute("DROP TABLE IF EXISTS interval_timestamps")
    end
  end

end