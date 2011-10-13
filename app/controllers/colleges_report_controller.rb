class CollegesReportController < TableController
  FIELDS = [id_field,  { :field => "name", :label => "College" }, link_field(:link_proc => "college_path")] + purchase_fields
  TITLE = "College Report"

  def new
  end

  def index
    @rows = College.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
