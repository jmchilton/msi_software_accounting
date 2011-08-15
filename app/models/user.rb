class User < ReadOnlyModel
  set_table_name "users"
  set_primary_key "id"

  belongs_to :group, :foreign_key => "gid"
  belongs_to :person, :foreign_key => "person_id"

  has_many :events, :foreign_key => "unam", :primary_key => "username"
  
  def self.resource_counts(resource_id, from = nil, to = nil)
    select("count(*) as use_count, users.username").
    joins("INNER JOIN (#{Event.valid_events(from, to).to_sql}) e ON e.unam = users.username
                      INNER JOIN executable ex on e.feature = ex.identifier
                      INNER JOIN resources r on ex.rid = r.id").
    where("r.id = ?", resource_id).
    group("users.username")
  end

  def self.resource_report(resource_id, from = nil, to = nil)
    select("users.username, g.name as group_name, use_count").
    joins("INNER JOIN (#{resource_counts(resource_id, from, to).to_aliased_sql("iu")}) rc on rc.username = users.username
           INNER JOIN groups g on g.gid = users.gid")
  end

end
