class Event < ActiveRecord::Base
  set_table_name "event"
  set_primary_key "evid"

  belongs_to :resource, :foreign_key => "rid"

end
