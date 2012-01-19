class FlexlmAppSnapshot < ReadOnlyModel
  set_table_name "flexlm_app_snapshots"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'

  def self.sample_for_executable(executable_id, report_options = {})
    sample_by = report_options[:sample]

    group_by_date_expression = DateSampler.sample_date_expression report_options, "flexlm_app_snapshots.for_date"

    sample_with = report_options[:sample_with]
    case sample_with
      when "max"
        sample_expression = "max"
      else
        sample_expression = "avg"
    end

    select_expression = "#{sample_expression}(flexlm_app_snapshots.used_licenses) as value, max(flexlm_app_snapshots.total_licenses) as total_licenses, #{group_by_date_expression} as for_date"
    relation = select(select_expression).
      joins("INNER JOIN executable e on e.identifier = flexlm_app_snapshots.feature").
      where("e.exid = ?", executable_id).
      group(group_by_date_expression)
    DateOptions.handle_date_options(relation, 'FOR_DATE', report_options)
  end

  def self.index_raw_records
    # Doesn't do anything right now, someday may want to copy raw_* data over like we are doing with collectl data
  end

end