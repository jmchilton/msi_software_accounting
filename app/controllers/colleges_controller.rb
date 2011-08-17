class CollegesController < ApplicationController
  @@fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
               { :field => "name", :label => "College" },
               { :field => "num_packages", :label => "# Software Packages"},
               fy_10_field, fy_11_field, fy_12_field, fy_13_field
               ]

  
  def report
  end

  def show_report
    @fields = @@fields
    @rows = College.report(params[:from], params[:to])
    @title = "College Report"
    respond_with_table(allow_pagination = false)
  end

  # GET /colleges
  # GET /colleges.xml
  def index
    @colleges = College.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @colleges }
    end
  end

  # GET /colleges/1
  # GET /colleges/1.xml
  def show
    @college = College.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @college }
    end
  end

end
