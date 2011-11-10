class DepartmentExecutablesReportController < ReportController
  FIELDS = executable_fields

  protected

  def build_rows
    @rows = @department.executables_report(report_options)
    handle_executables_search_criteria
  end

end