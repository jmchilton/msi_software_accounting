class UserExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_user

  protected

  def build_rows
    @rows = @user.executables_report(report_options)
    handle_executables_search_criteria
  end

end