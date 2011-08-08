class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "rid"
 
  has_many :events, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"


  scope :report, select("resources.rid, resources.name, count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups").
                   where("event.operation = 'OUT'").
                   order("resources.name ASC").
                   joins(:events => { :process_user => :group}).
                   group("resources.name")

  def self.purchases_for(rid)
    where("rid = ?", rid).includes(:purchases).first.purchases
  end
end
