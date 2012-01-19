require 'aliased_sql'

class Group < ReadOnlyModel
  include HasUsageReports

  set_table_name "groups"
  set_primary_key "gid"

  USAGE_REPORT_FIELDS = "groups.gid as gid, groups.gid as id, groups.name as group_name, use_count"
  EMPLOYEE_GROUPS = "('tech', 'support', 'swinst')"

  def id
    gid
  end

  def self.resources(report_options)
    resource_id_column = report_options[:data_source] == :flexlm ? "rid" : "resource_id"
    select("groups.gid, ex.#{resource_id_column} as rid").
      joins(User.user_to_executables_joins "gid = groups.gid", report_options).
      group("groups.gid, ex.#{resource_id_column}")
  end

  def self.report(report_options = {})
    relation = select("groups.name, groups.gid, #{Purchase::REPORT_SELECT_FIELDS}").
               joins("inner join (#{resources(report_options).to_aliased_sql('ic')}) gr on groups.gid = gr.gid
                      #{Purchase.summary_left_join("gr.rid")}").
               order("groups.name ASC").
               group("groups.name, groups.gid")
    relation
  end

  def self.join_executables_sql(report_options)
    "INNER JOIN users ON users.gid = groups.gid #{User.join_executables_sql(report_options)}"
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/group/#{gid}/view"
  end

end
