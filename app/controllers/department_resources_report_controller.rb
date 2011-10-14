class DepartmentResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_department

  protected

  def build_rows
    @rows = @department.resources_report(report_options)
    handle_search_criteria :resource
  end

end