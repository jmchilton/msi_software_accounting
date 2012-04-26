class RawCollectlExecution < ActiveRecord::Base
  set_table_name "raw_collectl_executions"

  def self.unmapped_distinct(term)
    like_clause = (postgres? ? 'ILIKE' : 'LIKE')
    select("#{table_name}.executable as id, #{table_name}.executable").
    joins("left join collectl_executions ce on ce.id = #{table_name}.id").
    where("ce.id IS NULL").where("LOWER(#{table_name}.executable) #{like_clause} ?", "%#{term.downcase}%").
    group("#{table_name}.executable")
  end

  def self.postgres?
    defined?(PGConn)
  end

end