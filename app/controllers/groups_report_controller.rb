class GroupsReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "Group" }, link_field(:link_proc => "group_path")] + purchase_fields
  TITLE = "Groups Report"

  protected

  def build_rows
    @rows = Group.report(report_options)
    handle_search_criteria :name
  end

end
