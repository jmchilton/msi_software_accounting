class GroupsReportController < ReportController
  FIELDS = [id_field,  { :field => "name", :label => "Group" }] + purchase_fields
  TITLE = "Groups Report"

  def new
  end

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Group.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
