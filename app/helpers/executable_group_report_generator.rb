module ExecutableGroupReportGenerator
  include BaseReportGenerator

  protected

  def executable_group_report(executable = @executable)
    fields = [id_field,
              group_name_field,
              checkouts_field,
              link_field(:link_proc => "group_path")]
    rows = Group.executable_report executable.id, report_options
    rows = filter_search rows, :name
    [fields, rows]
  end

end