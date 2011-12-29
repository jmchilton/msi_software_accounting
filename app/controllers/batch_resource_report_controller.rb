class BatchResourceReportController < ReportController
  include ResourceCollegeReportGenerator
  include ResourceUserReportGenerator
  include ResourceDepartmentReportGenerator
  include ResourceGroupReportGenerator

  before_filter :set_model_type

  def new
    render :template => "batch_resource_#{@model_type}_report/new"
  end

  def index
    build_zip_for_resources "resource_#{@model_type}_report".to_sym
    render_report_zip "#{@model_type}_reports"
  end

end