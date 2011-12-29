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
    @fields, @rows = instance_eval report_method
  end

  def report_method
    self.class.name.underscore.sub /_controller/, ''
  end



end

