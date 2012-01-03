module ExecutableDepartmentReportGenerator
  include BaseReportGenerator

  protected

  def executable_department_report(executable = @executable)
    fields = [id_field,
              name_field,
              checkouts_field,
              link_field(:link_proc => "department_path")]
    rows = Department.executable_report executable.id, report_options
    rows = filter_search rows, :name
    [fields, rows]
  end

end