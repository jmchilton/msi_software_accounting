module ModelExecutablesReportGenerator
  include BaseReportGenerator

  protected

  def executables_report_for_model(model_type)
    instance  = model_instance
    rows = instance.executables_report(report_options)
    fields = executable_fields
    [fields, filter_for_executables(rows)]
  end

end