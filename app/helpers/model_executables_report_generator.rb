module ModelExecutablesReportGenerator
  include BaseReportGenerator

  protected

  def executables_report_for_model(model_type = @model_type)
    instance = instance_eval("@#{model_type}")
    rows = instance.executables_report(report_options)
    fields = executable_fields
    [fields, filter_for_executables(rows)]
  end

end