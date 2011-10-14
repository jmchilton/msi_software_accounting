class UserResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_user

  protected

  def build_rows
    @rows = @user.resources_report(report_options)
    handle_search_criteria :resource
  end

end