class ModelsReportController < ReportController
  include ModelsReportGenerator

  before_filter :check_model_type

  protected

  def report_method
    "#{model_type}s_report"
  end

end
