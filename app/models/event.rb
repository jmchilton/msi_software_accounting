class Event < ActiveRecord::Base
  set_table_name "event"
  set_primary_key "evid"

  belongs_to :resource, :foreign_key => "rid"
  belongs_to :process_user, :class_name => 'User', 
             :foreign_key => "user", :primary_key => "username"

end
