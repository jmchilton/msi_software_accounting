class Resource < ReadOnlyModel
  set_table_name "resources"
  set_primary_key "id"
 
  has_many :executables, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

  scope :report, select("resources.id, resources.name, count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups").
                   where("event.operation = 'OUT'").
                   order("resources.name ASC").
                   joins(:executables => { :events => { :process_user => :group} }).
                   group("resources.name")

  def self.purchases_for(rid)
    where("id = ?", rid).includes(:purchases).first.purchases
  end
end
