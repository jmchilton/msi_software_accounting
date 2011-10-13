class ExecutableGroupReportController < ReportController
  FIELDS = [id_field,
            group_name_field,
            checkouts_field,
            link_field(:link_proc => "group_path")]
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_executable

  def new
  end

  def index
    @rows = Group.executable_report(@executable.id, report_options)
    handle_search_criteria :group_name
    respond_with_report
  end

end
