module CollegeResourcesReportGenerator
  include BaseReportGenerator

  protected

  def college_resources_report
    fields = resources_fields(data_source)
    rows = @college.resources_report(report_options)
    rows = filter_search rows, :resource
    [fields, rows]
  end

end