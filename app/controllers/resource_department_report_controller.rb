class ResourceDepartmentReportController < ReportController
  FIELDS = [id_field,
            name_field,
            checkouts_field,
            link_field(:link_proc => "department_path")]
  TITLE = "FLEXlm Resource Usage"

  protected

  def build_rows
    @rows = Department.resource_report(@resource.id, report_options)
    handle_search_criteria :name
  end


end
