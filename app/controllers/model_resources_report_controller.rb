class ModelResourcesReportController < ReportController
  include UserResourcesReportGenerator
  include GroupResourcesReportGenerator
  include DepartmentResourcesReportGenerator
  include CollegeResourcesReportGenerator

  before_filter :check_model_type

  protected

  def report_method
    "#{model_type}_resources_report"
  end


end