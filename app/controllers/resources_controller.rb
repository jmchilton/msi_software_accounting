
class ResourcesController < ApplicationController
  autocomplete :resource, :name

  @@report_fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false, :search => false },
                     { :field => "name", :label => "Name" },
                     { :field => "num_users", :label => "# Users", :search => false },
                     { :field => "num_groups", :label => "# Groups", :search => false},
                     fy_10_field, fy_11_field, fy_12_field, fy_13_field,
                     ]
  @@report_title = "Resources Report"

  @@index_fields =
    [{ :field => "id", :label => "ID", :width => 35, :resizable => false, :search => false },
     { :field => "name", :label => "Name" },
     { :field => "link", :label => "View", :hidden => true, :link => true, :link_proc => "resource_path", :search => false} ]

  @@index_title = "Resources"

  @@usage_report_fields = [{:field => "username", :label => "Username"},
                           {:field => "group_name", :label=> "Group" },
                           {:field => "use_count", :label => "Checkouts", :search => false}]
  @@usage_report_title = "Resource Usage"

  def report
  end

  def show_report
    from = params[:from]
    to = params[:to]
    @rows = Resource.report(from, to)
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    @fields = @@report_fields
    @title = @@report_title
    respond_with_table(false)
  end

  def usage_report
  end
 
  def show_usage_report
    resource_id = params[:id]
    from = params[:from]
    to = params[:to]
    @resource = Resource.find(resource_id)
    @rows = User.resource_report(resource_id, from, to)
    if perform_search?
      @rows = @rows.where("users.username like ?", "%#{params[:username]}%").
                    where("group_name like ?", "%#{params[:group_name]}%")
    end
    @title = @@usage_report_title
    @fields = @@usage_report_fields
    respond_with_table(false)
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
    # @view_link = lambda { |row| resource_path(row) }
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
