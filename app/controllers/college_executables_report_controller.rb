class CollegeExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_college

  protected

  def build_rows
    @rows = @college.executables_report(report_options)
    handle_executables_search_criteria
  end

end