require 'aliased_sql'

class College < ReadOnlyModel
  include HasUsageReports

  set_table_name "colleges"
  set_primary_key "id"

  has_and_belongs_to_many :departments,
                          :join_table => "department_colleges",
                          :foreign_key => :college_id,
                          :association_foreign_key => :dept_id,
                          :class_name => 'Department'

  USAGE_REPORT_FIELDS = "colleges.id, colleges.name, use_count"

  def self.join_executables_sql(report_options)
    "INNER JOIN department_colleges on department_colleges.college_id = colleges.id
     INNER JOIN departments on departments.id = department_colleges.dept_id
     #{Department.join_executables_sql(report_options)}"
  end

  def self.resources(report_options = {})
    resource_id_column = report_options[:data_source] == :flexlm ? "rid" : "resource_id"
    select("colleges.id, ex.#{resource_id_column} as rid").
    joins("INNER JOIN department_colleges dc ON dc.college_id = colleges.id
           INNER JOIN departments ON departments.id = dc.dept_id
           #{Department.persons_to_executables_joins(report_options)}").
    group("colleges.id, ex.#{resource_id_column}")
  end

  def self.report(report_options = {})
    relation = select("colleges.id, colleges.name, #{Purchase::REPORT_SELECT_FIELDS}").
               joins("inner join (#{resources(report_options).to_aliased_sql('ic')}) cr on colleges.id = cr.id
                      #{Purchase.summary_left_join("cr.rid")}").
               order("colleges.name ASC").
               group("colleges.id, colleges.name")
    relation
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/college/#{id}/view"
  end

end
