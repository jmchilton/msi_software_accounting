class Event < ReadOnlyModel
  include JoinsDemographics

  set_table_name "event"
  set_primary_key "evid"

  belongs_to :executable, :foreign_key => "feature", :primary_key => "identifier", :class_name => 'Executable'
  belongs_to :process_user, :class_name => 'User', :foreign_key => "unam", :primary_key => "username"

  def self.valid_events(report_options = {})
    relation = where("OPERATION = 'OUT'")
    DateOptions.handle_date_options(relation, 'EV_DATE', report_options)
  end

  def self.join_users_on
    "users.username = e.unam"
  end

  def self.sql_user_list(list)
    sanitize_sql_array(["(#{(list.map{|x| "?"}).join(",")})"] + list)
  end

  def self.to_demographics_joins(report_options = {})
    "INNER JOIN (#{Event.valid_events(report_options).to_sql}) e on e.feature = executable.identifier #{join_valid_users_and_groups(report_options)}"
  end

end
