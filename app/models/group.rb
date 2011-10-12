class Group < ReadOnlyModel
  include HasUsageReports

  set_table_name "groups"
  set_primary_key "gid"

  USAGE_REPORT_FIELDS = "groups.name as group_name, use_count"

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

  def self.select_counts
    select("count(*) as use_count, groups.name").group("groups.name")
  end

  def self.join_executables_sql(report_options)
    "INNER JOIN users ON users.gid = groups.gid #{User.join_executables_sql(report_options)}"
  end

  def self.build_report_for_counts(counts_sql)
    select_report_fields.joins("INNER JOIN (#{counts_sql}) counts on counts.name = groups.name #{demographic_joins}")
  end

end
