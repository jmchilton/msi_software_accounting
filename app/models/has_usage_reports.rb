module HasUsageReports

  module ClassMethods

    def resource_counts(resource_id, report_options = {})
      select_counts.joins(join_resources_sql(report_options)).
                    where("r.id = ?", resource_id)
    end

    def join_resources_sql(report_options, join_type = "INNER")
      if report_options[:data_source] == :collectl
        resource_field = "resource_id"
      else
        resource_field = "rid"
      end
      "#{join_executables_sql(report_options)} #{join_type} JOIN resources r on ex.#{resource_field} = r.id"
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

  def executables_report(report_options = {})
    isolate_instance_and_join_resources(self.class.select("ex.exid as exid, ex.exid as id, ex.identifier, ex.comment, r.name as resource, count(*) as use_count").
          group("ex.exid, ex.identifier, ex.comment, r.name"), "INNER", report_options)
  end

  def resources_report(report_options = {})
    isolate_instance_and_join_resources(self.class.select("r.id as #{self.class.primary_key}, r.name as resource, count(*) as use_count").
          group("r.id, r.name"), "LEFT", report_options)
  end

  private

  def isolate_instance_and_join_resources(relation, join_type, report_options)
    relation.joins(self.class.join_resources_sql(report_options, join_type)).
             where("#{self.class.table_name}.#{self.class.primary_key} = ?", eval("#{self.class.primary_key}"))
  end


end