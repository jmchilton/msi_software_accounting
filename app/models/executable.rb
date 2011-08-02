class Executable < ActiveRecord::Base
  set_table_name "executable"
  set_primary_key "exid"
 
  belongs_to :resource, :foreign_key => "rid"
end
