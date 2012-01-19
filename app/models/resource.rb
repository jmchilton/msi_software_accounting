require 'aliased_sql'

class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "id"
 
  has_many :executables, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

  def escaped_name
    name.gsub /,/, "\\,"
  end

  def summarize(data_source)
    if data_source == :collectl
      CollectlExecutable.summary_select.where("collectl_executables.resource_id = ?", id).first
    elsif data_source == :flexlm
      Executable.summary_select.where("executable.rid = ?", id).first
    elsif data_source == :module
      SoftwareModule.summary_select.where("modules.resource_id = ?", id).first
    else
      raise ArgumentError, "Unknown data_source #{data_source}"
    end
  end

  def self.unescape_name escaped_name

  end

  def self.usage_report(report_options = {})
    data_source = report_options[:data_source]
    if data_source == :collectl
      usage_report_joins = "INNER JOIN collectl_executables on collectl_executables.resource_id = resources.id #{CollectlExecution.to_demographics_joins(report_options)}"
    elsif data_source == :flexlm
      usage_report_joins = "INNER JOIN executable on executable.rid = resources.id #{Event.to_demographics_joins(report_options)}"
    elsif data_source == :module
      usage_report_joins = "INNER JOIN modules on modules.resource_id = resources.id #{ModuleLoad.to_demographics_joins(report_options)}"
    else
      raise ArgumentError
    end
    select_statement = "resources.id, #{Resource.demographics_summary_selects}"
    select(select_statement).
      joins(usage_report_joins).
      group("resources.id")
  end

  def self.demographics_summary_selects
    "count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups"
  end

  def self.report(report_options = {})
    select("resources.id, resources.name, num_users, num_groups, fy10, fy11, fy12, fy13").
      joins("left join (#{Purchase.resource_summary.to_sql}) rs on rs.rid = resources.id
             inner join (#{Resource.usage_report(report_options).to_aliased_sql('ir')}) ur on ur.id = resources.id").
      order("resources.name")
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{id}/view"
  end

end
