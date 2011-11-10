class ResourcesReportController < ReportController
  FIELDS = [id_field,
                     resource_name_field,
                     num_users_field,
                     num_groups_field,
                     fy_10_field,
                     fy_11_field,
                     fy_12_field,
                     fy_13_field,
                     link_field(:link_proc => "resource_path")
                     ]

  protected

  def build_rows
    @rows = Resource.report(report_options)
    handle_search_criteria :name
  end

end
