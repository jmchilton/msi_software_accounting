class CollegeResourcesReportController < ReportController
  FIELDS = resources_fields

  protected

  def build_rows
    @rows = @college.resources_report(report_options)
    handle_search_criteria :resource
  end

end