class ExecutableUserReportController < ReportController

  EXECUTABLE_USER_REPORT_FIELDS = [self.id_field,
                                   self.name_field,
                                   self.num_users_field,
                                   self.num_groups_field]

  def index
    @resource = Resource.find(params[:resource_id])
    @fields = EXECUTABLE_USER_REPORT_FIELDS
    @rows = Executable.flexlm_report_for_resource(@resource.id, report_options)
    @title = "FLEXlm Feature Report for #{@resource.name}"
    respond_with_report
  end

  def new
    @resource = Resource.find(params[:resource_id])
  end

end