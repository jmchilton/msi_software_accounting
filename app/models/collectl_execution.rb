class CollectlExecution < ReadOnlyModel
  set_table_name "collectl_executions"

  belongs_to :user
  belongs_to :executable

end