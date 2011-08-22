class ExecutablesReportController < ReportController

  FIELDS = [self.id_field,
            self.name_field,
            self.num_users_field,
            self.num_groups_field,
            link_field(:link_proc => "executable_path")]

  def index
    @resource = Resource.find(params[:resource_id])
    @fields = FIELDS
    @rows = Executable.flexlm_report_for_resource(@resource.id, report_options)
    @title = "FLEXlm Feature Report for #{@resource.name}"
    respond_with_report
  end

  def new
    @resource = Resource.find(params[:resource_id])
  end

end