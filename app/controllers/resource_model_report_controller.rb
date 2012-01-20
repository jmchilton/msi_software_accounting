class ResourceModelReportController < ReportController
  include ResourceCollegeReportGenerator
  include ResourceDepartmentReportGenerator
  include ResourceGroupReportGenerator
  include ResourceUserReportGenerator

  before_filter :check_model_type

  protected

  def report_method
    "resource_#{model_type}_report"
  end

end
