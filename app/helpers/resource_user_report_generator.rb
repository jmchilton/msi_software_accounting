module ResourceUserReportGenerator
  include BaseReportGenerator

  protected

  def resource_user_report(resource = @resource)
    fields = [id_field,
               username_field,
               first_name_field,
               last_name_field,
               email_field,
               group_name_field,
               college_name_field,
               use_count_field(data_source),
               link_field(:link_proc => "user_path")]

    rows = User.resource_report(resource.id, report_options)
    rows = filter_search rows, :username
    rows = filter_search rows, :group_name
    rows = filter_search rows, :college_name
    [fields, rows]
  end
end