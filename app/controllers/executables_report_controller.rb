class ExecutablesReportController < ReportController
  FIELDS = [self.id_field,
            self.name_field,
            self.num_users_field,
            self.num_groups_field,
            link_field(:link_proc => "executable_path")]

  before_filter :set_resource

  protected

  def build_rows
    @rows = Executable.flexlm_report_for_resource(@resource.id, report_options)
    @title = "FLEXlm Feature Report for #{@resource.name}"
  end

end