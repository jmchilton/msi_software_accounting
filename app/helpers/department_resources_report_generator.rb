module DepartmentResourcesReportGenerator
  include BaseReportGenerator

  protected

  def department_resources_report
    fields = resources_fields(data_source)
    rows = @department.resources_report(report_options)
    rows = filter_search rows, :resource
    [fields, rows]
  end

end