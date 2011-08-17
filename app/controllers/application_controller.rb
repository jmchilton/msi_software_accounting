class ApplicationController < ActionController::Base 
  include ApplicationHelper
  protect_from_forgery

  protected

  def self.fy_10_field
   { :field => "fy10", :label => "Cost (FY 2010)"}
  end

  def self.fy_11_field
    { :field => "fy11", :label => "Cost (FY 2011)"}
  end

  def self.fy_12_field
    { :field => "fy12", :label => "Cost (FY 2012)"}
  end

  def self.fy_13_field
    { :field => "fy13", :label => "Cost (FY 2013)"}
  end

  def setup_rows(for_json = false)
    if @allow_pagination
      @row_count = @rows.count
      @rows = with_pagination_and_ordering(@rows)
    end
    if !@view_link.blank?
      @fields.push({:field => "link", :hidden => true})
      if for_json
        @rows.each { |row| row[:link] = @view_link.call(row) }
      end
    end
  end


  def respond_with_table(allow_pagination = true)
    @allow_pagination = allow_pagination
    @rows_per_page = allow_pagination ? 50 : 10000
    @row_list = allow_pagination ? '[10,25,100]' : '[]'
    @scroll = ! allow_pagination
    respond_to do |format|
      format.html {
        setup_rows
        render :html => @rows
      }
      format.xml  {
        setup_rows
        render :xml => @rows
      }
      format.csv {
        setup_rows
        render_csv(@title + ".csv")
      }
      format.json {
        setup_rows(true)
        keys = @fields.map { |field| field[:field] }
        @rows = @rows.all
        puts "Calculating row count"
        if not @allow_pagination
          @row_count = @rows.count
        end
        puts "Calculated"
        render :json => @rows.to_jqgrid_json(keys, params[:page], params[:rows], @row_count)
      }
    end
  end

  def perform_search?
    params[:_search] == "true"
  end

  def with_pagination_and_ordering(relation)
    unless params[:page].blank? or params[:rows].blank?
      page = params[:page]
      rows = params[:rows]
      offset = (page.to_i - 1) * rows.to_i
      relation = relation.offset(offset).limit(rows)
    end
    unless params[:sidx].blank?
      order = params[:sidx]
      unless params[:sord].blank?
        order = order + " " + params[:sord]
      end
      relation = relation.reorder(order)
    end
    relation
  end

  # http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file
  def render_csv(filename = nil)
    filename ||= params[:action]
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
    end

    render :template => '/spreadsheet', :layout => false
  end

end
