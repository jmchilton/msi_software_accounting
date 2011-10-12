class Group < ReadOnlyModel
  set_table_name "groups"
  set_primary_key "gid"

  def self.resources(report_options)
    select("groups.gid, ex.rid").
      joins(User.user_to_executables_joins "gid = groups.gid", report_options).
      group("groups.gid, ex.rid")
  end

  def self.report(report_options = {})
    relation = select("groups.name, #{Purchase::REPORT_SELECT_FIELDS}").
               joins("left join (#{resources(report_options).to_aliased_sql('ic')}) gr on groups.gid = gr.gid
                      #{Purchase.summary_left_join("gr.rid")}").
               order("groups.name ASC").
               group("groups.name")
    relation
  end

end
