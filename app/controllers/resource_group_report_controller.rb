class ResourceGroupReportController < ReportController
  FIELDS = [id_field("gid"),
            id_field,
            group_name_field,
            checkouts_field,
            link_field(:link_proc => "group_path")]
  TITLE = "FLEXlm Resource Usage"

  protected

  def build_rows
    @rows = Group.resource_report(@resource.id, report_options)
    handle_search_criteria :group_name
  end


end
