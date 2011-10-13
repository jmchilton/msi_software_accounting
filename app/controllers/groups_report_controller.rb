class GroupsReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "Group" }, link_field(:link_proc => "group_path")] + purchase_fields
  TITLE = "Groups Report"

  def new
  end

  def index
    @rows = Group.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
