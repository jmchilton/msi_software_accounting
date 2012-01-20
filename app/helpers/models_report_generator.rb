module ModelsReportGenerator
  include BaseReportGenerator

  protected

  def colleges_report
    fields = [id_field,  { :field => "name", :label => "College" }, link_field(:link_proc => "college_path")] + purchase_fields
    models_report(College, fields)
  end

  def departments_report
    fields = [id_field,  { :field => "name", :label => "Department" }, link_field(:link_proc => "department_path")] + purchase_fields
    models_report(Department, fields)
  end

  def groups_report
    fields = [id_field,  { :field => "name", :label => "Group" }, link_field(:link_proc => "group_path")] + purchase_fields
    models_report(Group, fields)
  end

  def models_report(model_class, fields)
    rows = model_class.report(report_options)
    rows = filter_search rows, :name
    [fields, rows]
  end

end