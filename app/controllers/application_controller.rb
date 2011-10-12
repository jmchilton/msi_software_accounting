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

  def handle_search_criteria(field)
    if perform_search?
      @rows = @rows.where("#{field.to_s} like ?", "%#{params[field]}%")
    end
  end

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

  def self.checkouts_field
    {:field => "use_count", :label => "Checkouts", :search => false}
  end

  def self.username_field
    { :field => "username", :label => "Username"}
  end

  def self.first_name_field
    { :field => "first_name", :label => "First Name"}
  end

  def self.last_name_field
    { :field => "last_name", :label => "Last Name"}
  end

  def self.group_name_field
    { :field => "group_name", :label => "Group Name" }
  end

  def self.college_name_field
    { :field => "college_name", :label => "College" }
  end

  def self.email_field
    { :field => "email", :label => "E-Mail"}
  end

  def self.name_field
    { :field => "name", :label => "Name" }
  end

  def self.num_users_field
    { :field => "num_users", :label => "# Users", :search => false }
  end

  def self.num_groups_field
    { :field => "num_groups", :label => "# Groups", :search => false}
  end

  def self.id_field
    { :field => "id", :label => "ID",  :resizable => false, :search => false, :hidden => true }
  end

  def self.fy_10_field
   fy_field(10)
  end

  def self.fy_11_field
    fy_field(11)
  end

  def self.fy_12_field
    fy_field(12)
  end

  def self.fy_13_field
    fy_field(13)
  end

  def self.fy_field(year)
    { :field => "fy"+year.to_s, :label => "Cost (FY 20#{year.to_s})", :search => false }
  end

  def self.link_field(options = {})
    options.reverse_merge({ :field => "link", :label => "View", :hidden => true, :link => true, :search => false})
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
          expression = "#{field[:link_proc]}(row)"
          value = eval(expression)
          row[key] = value
        end
      end
    end
  end

  def process_rows(for_json = false)
    if for_json and @allow_pagination
      @row_count = @rows.count
    end
    if @allow_pagination
      @rows = with_pagination_and_ordering(@rows)
    end
    if for_json
      @rows = @rows.all
      append_links_to_rows
    end

    if for_json and not @allow_pagination
      @row_count = @rows.count
    end
  end

  def respond_with_table(allow_pagination = true)
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
        render_csv(@title)
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

  def set_enable_javascript
    if params[:enable_javascript].blank?
      params[:enable_javascript] = session[:enable_javascript]
    else
      session[:enable_javascript] = params[:enable_javascript]
    end
  end

end
