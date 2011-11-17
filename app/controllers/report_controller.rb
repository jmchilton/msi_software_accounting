class ReportController < TableController
  include ReportHelper

  def new
  end

  def index
    build_rows
    respond_with_report
  end

  protected

  def build_rows
    report_method = self.class.name.underscore.sub /_controller/, ''
    @fields, @rows = instance_eval report_method
  end

end

