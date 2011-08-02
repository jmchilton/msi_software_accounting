class Purchase < ActiveRecord::Base
  set_table_name "purchase"
  set_primary_key "pid"

  belongs_to :resource, :foreign_key => "rid"
end
