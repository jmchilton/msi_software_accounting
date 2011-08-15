
class ResourcesController < ApplicationController
  @@report_fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
                     { :field => "name", :label => "Name" },
                     { :field => "num_users", :label => "# Users"},
                     { :field => "num_groups", :label => "# Groups"},
                     { :field => "fy10", :label => "Cost (FY 2010)"},
                     { :field => "fy11", :label => "Cost (FY 2011)"},
                     { :field => "fy12", :label => "Cost (FY 2012)"},
                     { :field => "fy13", :label => "Cost (FY 2013)"}]
  @@report_title = "Resources Report"

  @@index_fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false }, 
                    { :field => "name", :label => "Name" }]
  @@index_title = "Resources"

  @@usage_report_fields = [{:field => "username", :label => "Username"},
                           {:field => "group_name", :label=> "Group" },
                           {:field => "use_count", :label => "Checkouts"}]
  @@usage_report_title = "Resource Usage"

  def report
  end

  def show_report
    from = params[:from]
    to = params[:to]
    @rows = with_pagination_and_ordering(Resource.report(from, to))
    @fields = @@report_fields
    @title = @@report_title
    respond_with_table
  end

  def usage_report
  end
 
  def show_usage_report
    resource_id = params[:id]
    from = params[:from]
    to = params[:to]
    @rows = with_pagination_and_ordering(User.resource_report(resource_id, from, to))
    @title = @@usage_report_title
    @fields = @@usage_report_fields
    respond_with_table
  end 

  # GET /resources
  # GET /resources.xml
  def index
    @fields = @@index_fields
    @title = @@index_title
    @rows = with_pagination_and_ordering(Resource).all
    @view_link = lambda { |row| resource_path(row) }
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