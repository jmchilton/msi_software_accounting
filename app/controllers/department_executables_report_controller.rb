class DepartmentExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_department

  protected

  def build_rows
    @rows = @department.executables_report(report_options)
    handle_executables_search_criteria
  end

end