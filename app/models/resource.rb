class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "id"
 
  has_many :executables, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

  
  scope :usage_report, select("resources.id, count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups").
                       where("event.operation = 'OUT'").
                       joins(:executables => { :events => { :process_user => :group} }).
                       group("resources.id")

  scope:report, select("resources.id, resources.name, num_users, num_groups, fy10, fy11, fy12, fy13").
                joins("inner join (#{Purchase.resource_summary.to_sql}) rs on rs.rid = resources.id                                            
                       inner join (#{Resource.usage_report.to_aliased_sql('ir')}) ur on ur.id = resources.id").
                order("resources.name")

                
  def self.purchases_for(rid)
    where("id = ?", rid).includes(:purchases).first.purchases
  end
end
