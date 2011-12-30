require 'fields'

class TableController < ApplicationController
  include TableHelper
  extend Fields
  include Fields

  before_filter :save_report_options

  protected

  def respond_with_report
    respond_with_table(false)
  end

  def handle_executables_search_criteria
    handle_search_criteria :resource
    handle_search_criteria :identifier
    handle_search_criteria :comment
  end

  def filter_for_executables(rows)
    rows = filter_search rows, :resource
    rows = filter_search rows, :identifier
    rows = filter_search rows, :comment
    rows
  end

  def save_report_option(option)
    if not params[option].nil?
      session["last_#{option}".to_sym] = params[option]
    end
  end

  def save_report_options
    [:from, :to, :exclude_employees, :limit_users].each do |option|
      save_report_option option
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


end