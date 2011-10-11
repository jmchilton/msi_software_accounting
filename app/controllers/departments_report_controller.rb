class DepartmentsReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "Department" }] + purchase_fields
  TITLE = "Department Report"

  def new
  end

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Department.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
