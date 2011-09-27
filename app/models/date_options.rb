module DateOptions
  def self.handle_date_options(relation, col_name, options)
    options.reverse_merge!({:from => nil, :to => nil})
    from = options[:from]
    to = options[:to]
    unless from.blank?
      relation = relation.where("#{col_name} >= ?", from)
    end
    unless to.blank?
      relation = relation.where("#{col_name} <= ?", to)
    end
    relation
  end
end