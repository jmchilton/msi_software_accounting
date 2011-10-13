class ResourceGroupReportController < TableController
  FIELDS = [id_field("gid"),
            id_field,
            group_name_field,
            checkouts_field,
            link_field(:link_proc => "group_path")]
  TITLE = "FLEXlm Resource Usage"

  before_filter :set_resource

  def new
  end

  def index
    @rows = Group.resource_report(@resource.id, report_options)
    handle_search_criteria :group_name
    respond_with_report
  end


end
