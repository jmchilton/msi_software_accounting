class CollegesReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "College" }, link_field(:link_proc => "college_path")] + purchase_fields

  protected

  def build_rows
    @rows = College.report(report_options)
    handle_search_criteria :name
  end

end
