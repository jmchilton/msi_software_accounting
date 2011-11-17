require 'time_flot'

class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :set_enable_javascript

  DEFAULT_NUM_ROWS_PAGINATE = 20
  DEFAULT_NUM_ROWS_NO_PAGINATE = 10000
  ROW_LIST_PAGINATE = '[10,20,100]'
  ROW_LIST_NO_PAGINATE = '[]'

  DEFAULT_CHART_ID="chart"

  protected

  def from_date
    Date.parse(params[:from]) unless params[:from].blank?
  end

  def to_date
    Date.parse(params[:to]) unless params[:to].blank?
  end

  def init_chart_data
    if @chart_data.blank?
      xaxis_options= {}
      unless from_date.blank?
        xaxis_options.merge! :min => from_date.to_time.to_i * 1000
      end

      unless to_date.blank?
        xaxis_options.merge! :max => to_date.to_time.to_i * 1000
      end

      @chart_data = TimeFlot.new(DEFAULT_CHART_ID) do |f|
        f.lines({:show => true, :fill => false, :steps => true})
        #f.legend({:container => '#flot_legend', :noColumns => 1 })
        #f.points
        f.xaxis xaxis_options.merge({:tickDecimals => false, :mode => :time, :minTickSize => [1, "day"]})
        f.yaxis :tickDecimals => false, :min => 0
        f.grid :hoverable => true
        f.selection :mode => "x"
      end
    end
  end

  def add_line_chart_data(data, label = nil, options = {})
    init_chart_data
    @chart_data.series(label, data, options)
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

  def append_links_to_rows
    @fields.each do |field|
      key = field[:field]
      is_link = field[:link]
      if is_link
        @rows.each do |row|
          row_id = row.id
          if row_id.nil?
            puts "Warning: Null row id for row #{row}"
          else
            link_proc = field[:link_proc]
            if link_proc.is_a? String
              expression = "#{field[:link_proc]}('#{row_id}')"
              value = eval(expression)
            else
              value = link_proc.call(row_id)
            end
            row[key] = value
          end
        end
      end
    end

  end

  def get_relation_record_count(relation)
    sql = "SELECT COUNT(*) as record_count FROM (#{@rows.to_sql}) as tmp" # postgres requires subselect to have alias
    active_record_result = ActiveRecord::Base.connection.select_one(sql)
    active_record_result["record_count"].to_i
  end

  def set_record_count
    if @rows.is_a? ActiveRecord::Relation
      @row_count = get_relation_record_count(@rows)
    else
      @row_count = @rows.count
    end
  end

  def process_rows(for_json = false)
    if for_json and @allow_pagination
      set_record_count
    end
    if @allow_pagination
      @rows = with_pagination_and_ordering(@rows)
    end
    if for_json
      @rows = @rows.all
      append_links_to_rows
    end
    if for_json and not @allow_pagination
      set_record_count
    end
  end

  def respond_with_table(allow_pagination = true)
    unless instance_variable_defined? :@fields
      @fields = self.class::FIELDS
    end
    @allow_pagination = allow_pagination
    @rows_per_page = allow_pagination ? DEFAULT_NUM_ROWS_PAGINATE : DEFAULT_NUM_ROWS_NO_PAGINATE
    @row_list = allow_pagination ? ROW_LIST_PAGINATE : ROW_LIST_NO_PAGINATE
    @scroll = !allow_pagination

    respond_to do |format|
      format.html {
        process_rows
        render :html => @rows
      }
      format.csv {
        process_rows
        render_csv()
      }
      format.json {
        process_rows(true)
        render :json => get_json
      }
    end
  end

  def perform_search?
    params[:_search] == "true"
  end

  def get_json
    keys = @fields.map { |field| field[:field] }
    page = params[:page] || 1
    rows = params[:rows] || @row_count
    @rows.to_jqgrid_json(keys, page, rows, @row_count)
  end

  def render_report_to_str(report_name, *args)
    fields, rows = send(report_name, *args)
    render_csv_to_string fields, rows
  end

  def render_csv_to_string(fields, rows)
    csv_fields = filter_fields_for_csv fields
    [csv_header(csv_fields), csv_contents(rows, csv_fields)].join "\n"
  end

  def filter_fields_for_csv(fields)
    fields.find_all { |field| field[:field] != "link" && (field[:hidden].blank? || !field[:hidden]) }
  end

  # http://stackoverflow.com/questions/94502/in-rails-how-to-return-records-as-a-csv-file
  def render_csv(filename = nil)
    filename ||= params[:action]
    filename += '.csv'

    set_filename filename
    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain" 
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Expires'] = "0" 
    else
      headers["Content-Type"] ||= 'text/csv'
    end
    @csv_fields = filter_fields_for_csv @fields
    render :template => '/spreadsheet', :layout => false
  end

  def set_filename filename
    headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
  end

  def set_enable_javascript
    if params[:enable_javascript].blank?
      params[:enable_javascript] = session[:enable_javascript]
    else
      session[:enable_javascript] = params[:enable_javascript]
    end
  end

  def find_and_show(model_class, instance_variable_name = nil)
    if instance_variable_name.nil?
      instance_variable_name = "@#{model_class.name.downcase}".to_sym
    end
    object = model_class.find(params[:id])
    instance_variable_set instance_variable_name, object
    show_object(object)
  end

  def show_object(object)
    respond_to do |format|
      format.html
      format.xml  { render :xml => object }
    end
  end

  def selected_resources
    param_resource_names.collect { |resource_name| Resource.find_by_name resource_name }
  end

  def selected_resource(resource_name = params[:resource_name])
    if resource_name.blank?
      nil
    else
      unescaped_resource_name = (resource_name.gsub /\\,/, ",")
      Resource.find_by_name unescaped_resource_name
    end
  end

  def param_resource_names
    resource_names = params[:resource_name]
    resource_names.gsub! /\\,/, "COMMA" # Replace escaped comma, so we can split on comma
    resource_names.split(",").collect { |escaped_name| escaped_name.gsub /COMMA/, ","}
  end

end
