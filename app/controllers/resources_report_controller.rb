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
  TITLE = "Resources Report"

  def new
  end

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Resource.report(report_options)
    handle_search_criteria :name
    respond_with_report
  end

end
