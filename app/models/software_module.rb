# Would prefer the name Module, but that understandably doesn't seem to play well with Ruby
class SoftwareModule < ActiveRecord::Base
  set_table_name "modules"

  belongs_to :resource, :foreign_key => "name", :primary_key => "module", :class_name => 'Resource'

end