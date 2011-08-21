
class ResourcesController < ReportController
  autocomplete :resource, :name

  @@report_fields = [id_field,
                     name_field,
                     num_users_field,
                     num_groups_field,
                     fy_10_field,
                     fy_11_field,
                     fy_12_field,
                     fy_13_field,
                     link_field(:link_proc => "resources_usage_report_path")
                     ]
  @@report_title = "Resources Report"

  @@index_fields =
    [id_field,
     name_field,
     link_field(:link_proc => "resource_path")]

  @@index_title = "Resources"

  @@usage_report_fields = [{:field => "username", :label => "Username"},
                           {:field => "group_name", :label=> "Group" },
                           {:field => "use_count", :label => "Checkouts", :search => false},
                           link_field(:link_proc => "user_path")]
  @@usage_report_title = "Resource Usage"

  def report
  end

  def show_report
    @rows = Resource.report(report_options)
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    @fields = @@report_fields
    @title = @@report_title
    respond_with_report
  end

  def usage_report
  end
 
  def show_usage_report
    resource_id = params[:id]
    @resource = Resource.find(resource_id)
    @rows = User.resource_report(resource_id, report_options)
    if perform_search?
      @rows = @rows.where("users.username like ?", "%#{params[:username]}%").
                    where("group_name like ?", "%#{params[:group_name]}%")
    end
    @title = @@usage_report_title
    @fields = @@usage_report_fields
    respond_with_report
  end 

  # GET /resources
  # GET /resources.xml
  def index
    @fields = @@index_fields
    @title = @@index_title
    @rows = Resource
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    respond_with_table
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

end
