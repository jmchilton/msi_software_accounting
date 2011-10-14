class GroupResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_group

  protected

  def build_rows
    @rows = @group.resources_report(report_options)
    handle_search_criteria :resource
  end

end