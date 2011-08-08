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


end
