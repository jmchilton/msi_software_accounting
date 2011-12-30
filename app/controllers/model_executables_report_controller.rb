class ModelExecutablesReportController < ReportController
  include ModelExecutablesReportGenerator

  before_filter :set_model_type

  def new
    render :template => "#{@model_type}_executables_report/new"
  end

  protected

  def report_method
    "executables_report_for_model"
  end

  def table_template
    "#{@model_type}_executables_report/index"
  end

  protected

  def set_granulatiy

  end


end