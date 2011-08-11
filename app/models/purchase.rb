class Purchase < ActiveRecord::Base
  set_table_name "purchase"
  set_primary_key "pid"

  belongs_to :resource, :foreign_key => "rid"

  scope :resource_summary, 
    select("rid, sum(fy10) as fy10, 
            sum(fy11) as fy11, sum(fy12) as fy12, 
            sum(fy13) as fy13").
    group("rid")

end
