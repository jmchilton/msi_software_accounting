class ResourceDepartmentReportController < ReportController

  protected

  def build_rows
    @fields =  [id_field,
                name_field,
                use_count_field(data_source),
                link_field(:link_proc => "department_path")]

    @rows = Department.resource_report(@resource.id, report_options)
    handle_search_criteria :name
  end


end
