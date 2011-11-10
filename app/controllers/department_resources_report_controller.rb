class DepartmentResourcesReportController < ReportController

  protected

  def build_rows
    @fields = resources_fields(data_source)
    @rows = @department.resources_report(report_options)
    handle_search_criteria :resource
  end

end