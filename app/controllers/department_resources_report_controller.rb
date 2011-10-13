class DepartmentResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_department

  def new
  end

  def index
    @title = TITLE
    @fields = FIELDS
    @rows = @department.resources_report(report_options)
    handle_search_criteria :resource
    respond_with_report
  end
end