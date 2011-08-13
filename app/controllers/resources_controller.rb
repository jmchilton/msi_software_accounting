require 'hashery/dictionary.rb'

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

  def report
  end

  def show_report
    @fields = @@report_fields
    @rows = with_pagination_and_ordering(Resource.report)
    @title = @@report_title
    respond_with_table
  end

  def usage_report
  end
 
  def show_usage_report
  end 

  # GET /resources
  # GET /resources.xml
  def index
    @fields = @@index_fields
    @title = @@index_title
    @rows = with_pagination_and_ordering(Resource).all
    @view_link = lambda { |row| resources_path(row) }
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
