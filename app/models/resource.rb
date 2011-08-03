class Resource < ActiveRecord::Base
  set_table_name "resources"
  set_primary_key "rid"
 
  has_many :events, :foreign_key => "rid"
  has_many :purchases, :foreign_key => "rid"

end
