class ResourcesReportController < ReportController
  FIELDS = [id_field,
                     name_field,
                     num_users_field,
                     num_groups_field,
                     fy_10_field,
                     fy_11_field,
                     fy_12_field,
                     fy_13_field,
                     link_field(:link_proc => "resource_path")
                     ]
  @@report_title = "Resources Report"

  def new
  end

  def index
    @rows = Resource.report(report_options)
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    @fields = FIELDS
    @title = @@report_title
    respond_with_report
  end

end
