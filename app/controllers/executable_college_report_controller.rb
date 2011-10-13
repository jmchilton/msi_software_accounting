class ExecutableCollegeReportController < ReportController
  FIELDS = [id_field,
            name_field,
            checkouts_field,
            link_field(:link_proc => "college_path")]
  TITLE = "FLEXlm Feature Usage"

  before_filter :set_executable

  def new
  end

  def index
    @title = TITLE
    @fields = FIELDS
    @rows = College.executable_report(@executable.id, report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
