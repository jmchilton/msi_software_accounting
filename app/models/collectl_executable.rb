class CollectlExecutable < ActiveRecord::Base
  set_table_name "collectl_executables"

  has_many :collectl_executions, :class_name => 'CollectlExecution', :dependent => :delete_all, :inverse_of => :collectl_executable
  belongs_to :resource, :foreign_key => "resource_id"

  after_save :index

  validates :name, :presence => true


  def summarize
    CollectlExecutable.summary_select.where("collectl_executables.id = ?", id).first
  end

  def self.summary_select
    CollectlExecutable.select("count(*) as count, min(start_time) as first, max(start_time) as last").joins("inner join collectl_executions on collectl_executions.collectl_executable_id = collectl_executables.id")
  end

  private

  def index
    CollectlExecution.index_raw_records(self.id)
  end

end
