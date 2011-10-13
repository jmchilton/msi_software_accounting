class ResourceUserReportController < ReportController
  FIELDS = [id_field,
            username_field,
            first_name_field,
            last_name_field,
            email_field,
            group_name_field,
            college_name_field,
            checkouts_field,
            link_field(:link_proc => "user_path")]
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_resource

  def new
  end

  def index
    @rows = User.resource_report(@resource.id, report_options)
    handle_search_criteria :username
    handle_search_criteria :group_name
    handle_search_criteria :college_name
    respond_with_report
  end


end
