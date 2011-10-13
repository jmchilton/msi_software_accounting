class UserResourcesReportController < ReportController
  FIELDS = resources_fields
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_user

  def new
  end

  def index
    @rows = @user.resources_report(report_options)
    handle_search_criteria :resource
    respond_with_report
  end
end