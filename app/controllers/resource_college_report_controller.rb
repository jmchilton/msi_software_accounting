class ResourceCollegeReportController < ReportController
  FIELDS = [id_field,
            name_field,
            checkouts_field,
            link_field(:link_proc => "college_path")]

  protected

  def build_rows
    @rows = College.resource_report @resource.id, report_options
    handle_search_criteria :name
  end


end
