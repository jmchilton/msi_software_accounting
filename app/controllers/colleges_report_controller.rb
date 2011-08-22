class CollegesReportController < ReportController
  FIELDS = [id_field,
            { :field => "name", :label => "College" },
            { :field => "num_packages", :label => "# Software Packages", :search => false},
            fy_10_field,
            fy_11_field,
            fy_12_field,
            fy_13_field
           ]

  def new
  end

  def index
    @fields = FIELDS
    @rows = College.report(report_options)
    if perform_search?
      @rows = @rows.where("colleges.name like ?", "%#{params[:name]}%")
    end
    @title = "College Report"
    respond_with_report
  end

end
