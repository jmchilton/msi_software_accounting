class BatchResourceReportController < ReportController

  def index
    model_type = self.class.name.underscore.slice /.*_.*_(.*)_report_controller/, 1
    build_zip_for_resources "resource_#{model_type}_report".to_sym
    render_report_zip "#{model_type}_reports"
  end

end