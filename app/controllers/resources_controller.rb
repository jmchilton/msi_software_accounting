require 'hashery/dictionary.rb'

class ResourcesController < ApplicationController
  # @@fiscal_years = (10..13).map { |year| "fy#{year}"}

  helper_method :rows

  def rows
    @rows
  end

  def report
  end

  def show_report
    @columns = Dictionary[:fy10 => "Cost (FY 2010)",
                          :fy11 => "Cost (FY 2011)",
                          :fy12 => "Cost (FY 2012)",
                          :fy13 => "Cost (FY 2013)",
                          :name => "Name",
                          :num_users => "Unique Users",
                          :num_groups => "Unique Groups",
                          ]
    @rows = Resource.report.all
    @rows.each do |row| 
      purchases = Resource.purchases_for(row.rid)
      fiscal_years.each do |fiscal_year|
        year_sum = purchases.map {|purchase| purchase.read_attribute(fiscal_year)}.sum()
        row[fiscal_year] = year_sum
      end
    end

    respond_to do |format|
      format.html
      format.csv { render_csv("resource_report.csv") }
    end
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

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(@resource, :notice => 'Resource was successfully created.') }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to(@resource, :notice => 'Resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end

  #helper_method :fiscal_years

  #def fiscal_years
  #  @@fiscal_years
  #end

end
