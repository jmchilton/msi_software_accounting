class CollectlExecutable < ActiveRecord::Base
  set_table_name "collectl_executables"

  belongs_to :resource, :foreign_key => "resource_id"

end
