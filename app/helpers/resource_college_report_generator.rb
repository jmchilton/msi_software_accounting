module ResourceCollegeReportGenerator
  include BaseReportGenerator

  protected

  def resource_college_report(resource = @resource)
    fields = [id_field,
               name_field,
               use_count_field(data_source),
               link_field(:link_proc => "college_path")]
    rows = College.resource_report resource.id, report_options
    rows = filter_search rows, :name
    [fields, rows]
  end

end