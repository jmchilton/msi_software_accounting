class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "id"
 
  has_many :executables, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

  
  def self.usage_report(from = nil, to = nil)
    select("resources.id, count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups").
      joins("INNER JOIN executable on executable.rid = resources.id
             INNER JOIN (#{Event.valid_events(from, to).to_sql}) e on e.feature = executable.identifier
             INNER JOIN users on users.username = e.unam
             INNER JOIN groups on users.gid = groups.gid").
      group("resources.id")
  end

  def self.report(from = nil, to = nil)
    select("resources.id, resources.name, num_users, num_groups, fy10, fy11, fy12, fy13").
                joins("left join (#{Purchase.resource_summary.to_sql}) rs on rs.rid = resources.id
                       inner join (#{Resource.usage_report(from, to).to_aliased_sql('ir')}) ur on ur.id = resources.id").
                order("resources.name")
  end

end
