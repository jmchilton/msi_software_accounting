class FlexlmAppSnapshot < ReadOnlyModel

  set_table_name "flexlm_app_snapshots"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'

  def self.summarize_for_executable(executable_id, report_options = {})
    sample_by = report_options[:sample]
    case sample_by
      when :date
        group_by_expression = "DATE(flexlm_app_snapshots.for_date)"
      else
        group_by_expression = "flexlm_app_snapshots.for_date"
    end
    relation = select("avg(flexlm_app_snapshots.used_licenses) as sum_avg, #{group_by_expression} as for_date").
      joins("INNER JOIN executable e on e.identifier = flexlm_app_snapshots.feature").
      where("e.exid = ?", executable_id).
      group(group_by_expression)
    DateOptions.handle_date_options(relation, 'FOR_DATE', report_options)
  end

end