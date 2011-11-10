class DepartmentResourcesReportController < ReportController
  FIELDS = resources_fields

  protected

  def build_rows
    @rows = @department.resources_report(report_options)
    handle_search_criteria :resource
  end

end