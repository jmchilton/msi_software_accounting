class ReportController < TableController
  def new
  end

  def index
    build_rows
    respond_with_report
  end

end

