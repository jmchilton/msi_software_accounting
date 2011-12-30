class ModelResourcesReportController < ReportController
  include UserResourcesReportGenerator
  include GroupResourcesReportGenerator
  include DepartmentResourcesReportGenerator
  include CollegeResourcesReportGenerator

  before_filter :set_model_type

  def new
    render :template => "#{@model_type}_resources_report/new"
  end

  protected

  def report_method
    "#{@model_type}_resources_report"
  end

  def table_template
    "#{@model_type}_resources_report/index"
  end

end