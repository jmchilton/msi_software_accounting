class GroupResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_group

  def new
  end

  def index
    @rows = @group.resources_report(report_options)
    handle_search_criteria :resource
    respond_with_report
  end

end