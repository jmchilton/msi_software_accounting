class DepartmentsReportController < TableController
  FIELDS = [id_field,  { :field => "name", :label => "Department" }, link_field(:link_proc => "department_path")] + purchase_fields
  TITLE = "Department Report"

  def new
  end

  def index
    @rows = Department.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
