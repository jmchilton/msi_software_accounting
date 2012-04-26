require 'faster_csv'

module TableHelper
  DEFAULT_NUM_ROWS_PAGINATE = 20
  DEFAULT_NUM_ROWS_NO_PAGINATE = 10000
  ROW_LIST_PAGINATE = '[10,20,100]'
  ROW_LIST_NO_PAGINATE = '[]'

  protected

  def handle_search_criteria(field, sql_column = nil)
    @rows = filter_search @rows, field, sql_column
  end

  def filter_search(rows, field, sql_column = nil)
    if sql_column.nil?
      sql_column = field.to_s
    end
    query = params[field]
    if perform_search?
      unless query.blank?
        rows = rows.where "#{sql_column} like ?", "%#{query}%"
      end
    end
    rows
  end

  def csv_header(csv_fields = @csv_fields)
     csv_fields.map{ |field| field[:label] }.join(",")
  end

  def csv_row(row, csv_fields)
    csv_fields.map {|field| cell_value(field, row) }
  end

  def csv_contents(rows = @rows, csv_fields = @csv_fields)
    FasterCSV.generate do |csv|
      rows.each { |row| csv << csv_row(row, csv_fields) }
    end
  end

  def handle_ordering(relation)
    if order_specified
      order = params[:sidx]
      unless params[:sord].blank?
        order = order + " " + params[:sord]
      end
      relation = relation.reorder(order)
    end
    relation
  end

  def order_specified
    not params[:sidx].blank?
  end

  def with_pagination_and_ordering(relation)
    unless params[:page].blank? or params[:rows].blank?
      page = params[:page]
      rows = params[:rows]
      offset = (page.to_i - 1) * rows.to_i
      relation = relation.offset(offset).limit(rows)
    end
    handle_ordering(relation)
  end

  def append_links_to_rows
    @fields.each do |field|
      key = field[:field]
      if is_link(field)
        @rows.each do |row|
          row[key] = link_value(field, row)
        end
      end
    end
  end

  def is_link(field)
    field[:link]
  end

  def link_value(field, row)
    row_id = row.id
    if row_id.nil?
      puts "Warning: Null row id for row #{row}"
      value = field[:field]
    else
      link_proc = field[:link_proc]
      if link_proc.is_a? String
        expression = "#{field[:link_proc]}('#{row_id}')"
        value = eval(expression)
      else
        value = link_proc.call(row_id)
      end
    end
    value
  end

  def process_rows(for_json = false)
    if for_json and @allow_pagination
      set_record_count
    end
    if @allow_pagination
      @rows = with_pagination_and_ordering(@rows)
    else
      @rows = handle_ordering(@rows)
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
        #render :html => @rows
        render :template => table_template
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

  def table_template
    "#{controller_name}/#{action_name}"
  end

  def cell_value(field, row)
    if is_link(field)
      link_to "View", link_value(field, row)
    else
      field_key = field[:field]
      if field_key.is_a?(Proc)
        field_key.call(row)
      else
        row[field_key.to_sym]
      end
    end
  end




  def clean_fields(fields)
    fields.collect do |hash|
      hash_copy = hash.clone
      hash_copy.delete :link_proc
      hash_copy
    end
  end

end