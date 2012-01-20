class CollectlExecution < ActiveRecord::Base
  include JoinsDemographics

  set_table_name "collectl_executions"

  belongs_to :user
  belongs_to :collectl_executable

  def self.valid_executions(report_options = {})
    relation = where("1=1")
    DateOptions.handle_date_options(relation, 'START_TIME', report_options)
  end

  def self.index_raw_records(executable_id = nil)
    if executable_id.nil?
      index_all_raw_records
    else
      index_raw_record_for_executable executable_id
    end

  end

  def self.join_users_on
    "users.id = e.user_id"
  end

  def self.to_demographics_joins(report_options = {})
    "INNER JOIN (#{CollectlExecution.valid_executions(report_options).to_sql}) e on e.collectl_executable_id = collectl_executables.id #{join_valid_users_and_groups(report_options)}"
  end

  def self.sample_for_executable(collectl_executable_id, report_options)
    with_interval_timestamps_table(report_options[:from], report_options[:to]) do
      sample_with = "max"
      if report_options[:sample_with] == "avg"
        sample_with = "avg"
      end

      group_by_date_expression = DateSampler.sample_date_expression report_options, "timestamp"
      samples = connection.select_all "SELECT #{sample_with}(sample_count) as value, #{group_by_date_expression} as for_date
                                            FROM
                                             (SELECT it.sample_date as timestamp, count(*) as sample_count
                                                FROM collectl_executions ce
                                                  INNER JOIN interval_timestamps it on it.sample_date between ce.start_time and ce.end_time
                                                WHERE ce.collectl_executable_id = '#{sanitize_sql(collectl_executable_id)}'
                                                GROUP BY it.sample_date)
                                                GROUP BY #{group_by_date_expression}"
      samples.collect { |row| row.symbolize_keys! }
    end
  end

  # http://richtextblog.blogspot.com/2007/09/mysql-temporary-tables-and-rails.html
  def self.with_interval_timestamps_table(from, to, step = 15 * 60)
    begin
      connection.execute("DROP TABLE IF EXISTS interval_timestamps")
      connection.execute("CREATE TEMPORARY TABLE interval_timestamps(sample_date timestamp)")
      from = Time.parse from
      to = Time.parse to
      timestamps = (from..to).step(15 * 60).collect { |timestamp| "INSERT INTO interval_timestamps (sample_date) VALUES ('#{timestamp.to_formatted_s(:db)}');" }
      timestamps.each { |insert| connection.execute insert }
      yield
    ensure
      # this drop is here to help keep the size of the database down
      # between calls to this method
      connection.execute("DROP TABLE IF EXISTS interval_timestamps")
    end


  end

  private

  UPDATE_EXECUTION_SQL = "update collectl_executions
                            set START_TIME = (select rce.START_TIME from raw_collectl_executions rce where rce.id = collectl_executions.id),
                                END_TIME   = (select rce.END_TIME   from raw_collectl_executions rce where rce.id = collectl_executions.id)"
  COLLECTL_EXECUTION_COLUMNS_SQL = "(ID, START_TIME, END_TIME, HOST, PID, USER_ID, COLLECTL_EXECUTABLE_ID)"

  def self.execute_index_insert(id_sql, execution_joins, where_clause)
    connection.execute "insert into collectl_executions #{COLLECTL_EXECUTION_COLUMNS_SQL}
                          select rce.ID, rce.START_TIME, rce.END_TIME, rce.HOST, rce.PID, u.id, #{id_sql}
                            from raw_collectl_executions rce
                              inner join users u on u.uid = rce.uid
                              #{execution_joins}
                            where #{where_clause}"
  end


  def self.index_all_raw_records
    execute_index_insert "ex.id", "inner join collectl_executables ex on ex.name = substr(rce.executable, -length(ex.name))", "1 not in (select 1 from collectl_executions ce where ce.ID = rce.ID)"
    connection.execute UPDATE_EXECUTION_SQL
  end

  def self.index_raw_record_for_executable(executable_id)
    collectl_executable = CollectlExecutable.find(executable_id)
    name = collectl_executable.name
    sanitized_executable_id = sanitize_sql(executable_id)
    execute_index_insert "'#{sanitized_executable_id}'", "left join collectl_executions ce on ce.id = rce.id", "substr(rce.executable, -#{name.length}) = '#{sanitize_sql(name)}' and ce.id is NULL"
    connection.execute "#{UPDATE_EXECUTION_SQL} where collectl_executable_id = '#{sanitized_executable_id}'"
  end

end