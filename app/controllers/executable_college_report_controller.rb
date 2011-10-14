class ExecutableCollegeReportController < ReportController
  FIELDS = [id_field,
            name_field,
            checkouts_field,
            link_field(:link_proc => "college_path")]
  TITLE = "FLEXlm Feature Usage"

  protected

  def build_rows
    @rows = College.executable_report(@executable.id, report_options)
    handle_search_criteria :name
  end

end
