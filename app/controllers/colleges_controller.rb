class CollegesController < ApplicationController
  
  def report
  end

  def show_report
    @fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
               { :field => "name", :label => "College" }]
    @rows = College.report
    @title = "College Report"
    respond_with_table
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
