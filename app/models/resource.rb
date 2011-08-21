class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "id"
 
  has_many :executables, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

  def self.usage_report(from = nil, to = nil)
    select_statement = "resources.id, #{Event.demographics_summary_selects}"
    select(select_statement).
      joins("INNER JOIN executable on executable.rid = resources.id #{Event.to_demographics_joins(from, to)}").
      group("resources.id")
  end

  def self.report(from = nil, to = nil)
    select("resources.id, resources.name, num_users, num_groups, fy10, fy11, fy12, fy13").
      joins("left join (#{Purchase.resource_summary.to_sql}) rs on rs.rid = resources.id
             inner join (#{Resource.usage_report(from, to).to_aliased_sql('ir')}) ur on ur.id = resources.id").
      order("resources.name")
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{id}/view"
  end


end
