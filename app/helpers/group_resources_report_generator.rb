module GroupResourcesReportGenerator
  include BaseReportGenerator

  protected

  def group_resources_report
    fields = resources_fields(data_source)
    rows = @group.resources_report(report_options)
    rows = filter_search rows, :resource
    [fields, rows]
  end

end