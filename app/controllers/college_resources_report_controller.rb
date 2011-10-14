class CollegeResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  protected

  def build_rows
    @rows = @college.resources_report(report_options)
    handle_search_criteria :resource
  end

end