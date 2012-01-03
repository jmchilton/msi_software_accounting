module ExecutableUserReportGenerator
  include BaseReportGenerator

  protected

  def executable_user_report(executable = @executable)
    fields = [id_field,
              username_field,
              first_name_field,
              last_name_field,
              email_field,
              group_name_field,
              college_name_field,
              checkouts_field,
              link_field(:link_proc => "user_path")]

    rows = User.executable_report(executable.id, report_options)
    rows = filter_search rows, :username
    rows = filter_search rows, :group_name
    rows = filter_search rows, :college_name
    [fields, rows]
  end

end