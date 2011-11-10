class ResourceUserReportController < ReportController

  protected

  def build_rows
    @fields = [id_field,
               username_field,
               first_name_field,
               last_name_field,
               email_field,
               group_name_field,
               college_name_field,
               use_count_field(data_source),
               link_field(:link_proc => "user_path")]

    @rows = User.resource_report(@resource.id, report_options)
    handle_search_criteria :username
    handle_search_criteria :group_name
    handle_search_criteria :college_name
  end


end
