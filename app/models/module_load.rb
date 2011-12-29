class ModuleLoad  < ActiveRecord::Base
  include JoinsDemographics

  set_table_name "module_loads"

  belongs_to :module, :foreign_key => "module_name", :primary_key => "name", :class_name => 'SoftwareModule'
  belongs_to :user, :class_name => 'User', :foreign_key => "username", :primary_key => "username"

  def self.valid_events(report_options = {})
    DateOptions.handle_date_options(ModuleLoad, 'date', report_options)
  end

end
