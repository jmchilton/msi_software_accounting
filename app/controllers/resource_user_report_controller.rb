class ResourceUserReportController < ReportController
  FIELDS = [id_field,
            {:field => "username", :label => "Username"},
            {:field => "group_name", :label=> "Group" },
            {:field => "use_count", :label => "Checkouts", :search => false},
            link_field(:link_proc => "user_path")]
  TITLE = "Resource Usage"

  def new
    resource_id = params[:resource_id]
    @resource = Resource.find(resource_id)
  end

  def index
    resource_id = params[:resource_id]
    @resource = Resource.find(resource_id)
    @rows = User.resource_report(resource_id, report_options)
    if perform_search?
      @rows = @rows.where("users.username like ?", "%#{params[:username]}%").
                    where("group_name like ?", "%#{params[:group_name]}%")
    end
    @title = TITLE
    @fields = FIELDS
    respond_with_report
  end

end
