class CollectlExecution < ReadOnlyModel
  set_table_name "collectl_executions"

  belongs_to :user
  belongs_to :collectl_executable

  def self.index_raw_records
    connection.execute "insert into collectl_executions (ID, START_TIME, END_TIME, HOST, PID, USER_ID, COLLECTL_EXECUTABLE_ID)
                          select rce.ID, rce.START_TIME, rce.END_TIME, rce.HOST, rce.PID, u.id, ex.id
                            from raw_collectl_executions rce
                              inner join users u on u.uid = rce.uid
                              inner join collectl_executables ex on ex.name = substr(rce.executable, -length(ex.name))
                              left join collectl_executions ce on rce.ID = ce.ID
                          where 1 not in (select 1 from collectl_executions ce where ce.ID = rce.ID)"
    connection.execute "update collectl_executions
                        set START_TIME = (select rce.START_TIME from raw_collectl_executions rce where rce.id = id),
                            END_TIME   = (select rce.END_TIME   from raw_collectl_executions rce where rce.id = id)"
  end

end