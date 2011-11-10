class ResourceGroupReportController < ReportController

  protected

  def build_rows
    @fields = [id_field("gid"), id_field, group_name_field, use_count_field(data_source), link_field(:link_proc => "group_path")]
    @rows = Group.resource_report(@resource.id, report_options)
    handle_search_criteria :group_name
  end


end
