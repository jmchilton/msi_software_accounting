require 'faster_csv'

module TableHelper

  protected

  def handle_search_criteria(field, sql_column = nil)
    @rows = filter_search @rows, field, sql_column
  end

  def filter_search(rows, field, sql_column = nil)
    if sql_column.nil?
      sql_column = field.to_s
    end
    query = params[:field]
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

end