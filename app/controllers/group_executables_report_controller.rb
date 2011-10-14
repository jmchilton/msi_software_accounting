class GroupExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  protected

  def build_rows
    @rows = @group.executables_report(report_options)
    handle_executables_search_criteria
  end

end