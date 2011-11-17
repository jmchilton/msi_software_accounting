class BatchResourceGroupReportController < ReportController
  include ResourceGroupReportGenerator

  def index
    build_zip_for_resources :resource_group_report
    render_report_zip :group_reports
  end

end
