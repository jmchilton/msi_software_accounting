module HasUsageReports

  module ClassMethods
  def resource_counts(resource_id, report_options = {})
    select_counts.joins("#{join_executables_sql(report_options)} INNER JOIN resources r on ex.rid = r.id").
                  where("r.id = ?", resource_id)
  end

  def executable_counts(executable_id, report_options = {})
    select_counts.joins(join_executables_sql(report_options)).where("ex.exid = ?", executable_id)
  end

  def executable_report(executable_id, report_options = {})
    build_report_for_counts(executable_counts(executable_id, report_options).to_aliased_sql("iu"))
  end

  def resource_report(resource_id, report_options = {})
    build_report_for_counts(resource_counts(resource_id, report_options).to_aliased_sql("iu"))
  end

  def select_report_fields
    select(self::USAGE_REPORT_FIELDS)
  end

  def select_counts
    select("count(*) as use_count, #{table_name}.#{primary_key} as id").group("#{table_name}.#{primary_key}")
  end

  def build_report_for_counts(counts_sql)
    select_report_fields.joins("INNER JOIN (#{counts_sql}) counts on counts.id = #{table_name}.#{primary_key} #{demographic_joins}")
  end

  def demographic_joins
    if self.const_defined? :USAGE_REPORT_DEMOGRAPHICS_JOINS
      self::USAGE_REPORT_DEMOGRAPHICS_JOINS
    else
      ""
    end
  end

  end



  def self.included(base)
    base.extend(ClassMethods)
  end


end