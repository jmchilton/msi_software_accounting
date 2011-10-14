class ExecutableDepartmentReportController < ReportController
  FIELDS = [id_field,
            name_field,
            checkouts_field,
            link_field(:link_proc => "department_path")]
  TITLE = "FLEXlm Feature Usage"

  protected

  def build_rows
    @rows = Department.executable_report(@executable.id, report_options)
    handle_search_criteria :name
  end

end
