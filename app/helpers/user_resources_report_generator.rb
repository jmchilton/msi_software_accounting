module UserResourcesReportGenerator
  include BaseReportGenerator

  protected

  def user_resources_report
    fields = resources_fields(data_source)
    rows = @user.resources_report(report_options)
    rows = filter_search rows, :resource
    [fields, rows]
  end

end