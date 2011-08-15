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
end
