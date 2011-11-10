class UserExecutablesReportController < ReportController
  FIELDS = executable_fields

  protected

  def build_rows
    @rows = @user.executables_report(report_options)
    handle_executables_search_criteria
  end

end