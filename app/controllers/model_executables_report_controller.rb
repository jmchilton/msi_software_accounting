class ModelExecutablesReportController < ReportController
  include ModelExecutablesReportGenerator

  before_filter :check_model_type

  protected

  def report_method
    "executables_report_for_model(model_type)"
  end

end