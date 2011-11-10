class DepartmentsReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "Department" }, link_field(:link_proc => "department_path")] + purchase_fields

  protected

  def build_rows
    @rows = Department.report(report_options)
    handle_search_criteria :name
  end

end
