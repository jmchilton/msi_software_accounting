class ModuleLoad  < ActiveRecord::Base
  include JoinsDemographics

  set_table_name "module_loads"

  belongs_to :module, :foreign_key => "name", :primary_key => "name", :class_name => 'SoftwareModule'
  belongs_to :user, :class_name => 'User', :foreign_key => "username", :primary_key => "username"

  def self.valid_events(report_options = {})
    DateOptions.handle_date_options(ModuleLoad.where("1=1"), 'date', report_options)
  end

  after_initialize :default_values



  def self.join_users_on
    "users.username = e.username"
  end

  def self.to_demographics_joins(report_options = {})
    "INNER JOIN (#{ModuleLoad.valid_events(report_options).to_sql}) e on e.name = modules.name #{join_valid_users_and_groups(report_options)}"
  end

  private
    def default_values
      self.date ||= Time.now
    end
end
