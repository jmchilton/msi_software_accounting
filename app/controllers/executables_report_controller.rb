class ExecutablesReportController < ReportController
  FIELDS = [self.id_field,
            self.name_field,
            self.num_users_field,
            self.num_groups_field,
            link_field(:link_proc => "executable_path")]

  protected

  def build_rows
    @rows = Executable.flexlm_report_for_resource(@resource.id, report_options)
  end

end