
module ResourceGroupReportGenerator
  include BaseReportGenerator

  protected

  def resource_group_report(resource = @resource)
    fields = [id_field("gid"), id_field, group_name_field, use_count_field(data_source), link_field(:link_proc => "group_path")]
    rows = Group.resource_report(resource.id, report_options)
    rows = filter_search rows, :group_name
    [fields, rows]
  end

end