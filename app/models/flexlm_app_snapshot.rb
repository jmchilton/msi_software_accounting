class FlexlmAppSnapshot < ReadOnlyModel
  set_table_name "flexlm_app_snapshots"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'


  def self.summarize_for_executable(executable_id, report_options = {})
    relation = select("avg(flexlm_app_snapshots.used_licenses) as sum_avg").
      joins("INNER JOIN executable e on e.identifier = flexlm_app_snapshots.feature").
      where("e.exid = ?", executable_id).
      group("flexlm_app_snapshots.id")
    puts relation.to_sql
    relation
  end

end