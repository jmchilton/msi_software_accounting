class ResourceCollegeReportController < ReportController

  protected

  def build_rows
    @fields = [id_field,
               name_field,
               use_count_field(data_source),
               link_field(:link_proc => "college_path")]
    @rows = College.resource_report @resource.id, report_options
    handle_search_criteria :name
  end


end
