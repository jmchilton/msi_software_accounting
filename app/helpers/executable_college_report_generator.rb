module ExecutableCollegeReportGenerator
  include BaseReportGenerator

  protected

  def executable_college_report(executable = @executable)
    fields = [id_field,
              name_field,
              checkouts_field,
              link_field(:link_proc => "college_path")]
    rows = College.executable_report executable.id, report_options
    rows = filter_search rows, :name
    [fields, rows]
  end

end