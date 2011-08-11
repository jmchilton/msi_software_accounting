require 'hashery/dictionary.rb'

class ResourcesController < ApplicationController

  def report
  end

  def show_report
    @fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
               { :field => "name", :label => "Name" },
               { :field => "num_users", :label => "# Users"},
               { :field => "num_groups", :label => "# Groups"},
               { :field => "fy10", :label => "Cost (FY 2010)"},
               { :field => "fy11", :label => "Cost (FY 2011)"},
               { :field => "fy12", :label => "Cost (FY 2012)"},
               { :field => "fy13", :label => "Cost (FY 2013)"}]
    @rows = Resource.report
    @title = "Resource Report"
    respond_with_table
  end

  # GET /resources
  # GET /resources.xml
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
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
