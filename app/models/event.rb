class Event < ReadOnlyModel
  set_table_name "event"
  set_primary_key "evid"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'
  belongs_to :process_user, :class_name => 'User', :foreign_key => "unam", :primary_key => "username"

  def self.valid_events(from, to)
    relation = where("OPERATION = 'OUT'")
    unless from.blank?
      relation = relation.where("EV_DATE >= ?", from)
    end
    unless to.blank?
      relation = relation.where("EV_DATE <= ?", to)
    end
    relation
  end

  def self.demographics_summary_selects
    "count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups"
  end

  def self.to_demographics_joins(from = nil, to = nil)
    "INNER JOIN (#{Event.valid_events(from, to).to_sql}) e on e.feature = executable.identifier
     INNER JOIN users on users.username = e.unam
     LEFT JOIN groups on users.gid = groups.gid"
  end

end
