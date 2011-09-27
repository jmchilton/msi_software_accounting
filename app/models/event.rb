class Event < ReadOnlyModel
  set_table_name "event"
  set_primary_key "evid"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'
  belongs_to :process_user, :class_name => 'User', :foreign_key => "unam", :primary_key => "username"

  def self.valid_events(report_options = {})
    relation = where("OPERATION = 'OUT'")
    DateOptions.handle_date_options(relation, 'EV_DATE', report_options)
  end

  def self.demographics_summary_selects
    "count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups"
  end

  def self.to_demographics_joins(report_options = {})
    "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e on e.feature = executable.identifier
     INNER JOIN users on users.username = e.unam
     LEFT JOIN groups on users.gid = groups.gid"
  end

end
