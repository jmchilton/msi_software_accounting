class DepartmentExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_department

  def new
  end

  def index
    @title = TITLE
    @fields = FIELDS
    @rows = @department.executables_report(report_options)
    handle_executables_search_criteria
    respond_with_report
  end

end