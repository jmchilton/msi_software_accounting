class ExecutableGroupReportController < ReportController
  FIELDS = [id_field,
            group_name_field,
            checkouts_field,
            link_field(:link_proc => "group_path")]

  protected

  def build_rows
    @rows = Group.executable_report(@executable.id, report_options)
    handle_search_criteria :group_name
  end

end
