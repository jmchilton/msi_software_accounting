class ExecutableModelReportController < ReportController
  include ExecutableCollegeReportGenerator
  include ExecutableDepartmentReportGenerator
  include ExecutableGroupReportGenerator
  include ExecutableUserReportGenerator

  before_filter :check_model_type

  protected

  def report_method
    "executable_#{model_type}_report"
  end

end
