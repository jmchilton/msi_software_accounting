require 'aliased_sql'

ActiveRecord::Relation.send :include, AliasedSql 
