class GroupExecutablesReportController < ReportController
  FIELDS = executable_fields
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_group

  def new
  end

  def index
    @title = TITLE
    @fields = FIELDS
    @rows = @group.executables_report(report_options)
    handle_executables_search_criteria
    respond_with_report
  end

end