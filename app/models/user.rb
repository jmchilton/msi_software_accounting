require 'static_data'

class User < ReadOnlyModel
  set_table_name "users"
  set_primary_key "id"

  belongs_to :group, :foreign_key => "gid"
  belongs_to :person, :foreign_key => "person_id"

  has_many :events, :foreign_key => "unam", :primary_key => "username"
  
  def self.resource_counts(resource_id, report_options = {})
    select("count(*) as use_count, users.username").
    joins("INNER JOIN (#{Event.valid_events(report_options).to_sql}) e ON e.unam = users.username
                      INNER JOIN executable ex on e.feature = ex.identifier
                      INNER JOIN resources r on ex.rid = r.id").
    where("r.id = ?", resource_id).
    group("users.username")
  end

  def self.resource_report(resource_id, report_options = {})
    select("users.id, users.username as username, groups.name as group_name, persons.first_name, persons.last_name, persons.email, use_count").
    joins("INNER JOIN (#{resource_counts(resource_id, report_options).to_aliased_sql("iu")}) rc on rc.username = users.username
           LEFT JOIN persons on users.person_id = persons.id
           LEFT JOIN groups on groups.gid = users.gid")
  end

  def msi_db_link
    "#{StaticData::MSIDB_CRUD_URL}people/user/#{id}/view"
  end

end
