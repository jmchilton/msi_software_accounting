class ApplicationController < ActionController::Base 
  include ApplicationHelper
  protect_from_forgery

  protected

  def respond_with_table
    if not @view_link.blank?
      @fields.push({:field => "link", :hidden => true})
      @rows.each { |row| row[:link] = @view_link.call(row) }
    end

    keys = @fields.map { |field| field[:field] }
    respond_to do |format|
      format.html { render :html => @rows }# index.html.erb
      format.xml  { render :xml => @row }
      format.csv { render_csv(@title + ".csv") }
      format.json {
        render :json => @rows.to_jqgrid_json(keys, params[:page], params[:rows], @rows.count)
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
