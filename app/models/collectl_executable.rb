class CollectlExecutable < ActiveRecord::Base
  set_table_name "collectl_executables"

  has_many :collectl_executions, :class_name => 'CollectlExecution', :dependent => :delete_all, :inverse_of => :collectl_executable
  belongs_to :resource, :foreign_key => "resource_id"

  after_save :index

  private

  def index
    CollectlExecution.index_raw_records(self.id)
  end

end
