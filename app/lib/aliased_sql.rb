

module AliasedSql 
  def to_aliased_sql(from_alias) 
    normal_sql = to_sql()
    from_matcher = Regexp.new("FROM\s+(\"?)#{table_name}(\"?) ")
    name_matcher = Regexp.new("(\s+\"?)#{table_name}(\"?)\\.")
    aliased_sql = normal_sql.gsub(from_matcher, "FROM \\1#{table_name}\\2 #{from_alias} ").
                             gsub(name_matcher, "\\1#{from_alias}\\2.")
    aliased_sql
  end
end
