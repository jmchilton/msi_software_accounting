class TableController < ApplicationController
  before_filter :save_report_options

  protected

  def respond_with_report
    respond_with_table(false)
  end

  def handle_executables_search_criteria
    handle_search_criteria :resource
    handle_search_criteria :identifier
    handle_search_criteria :comment
  end

  def self.resource_name_field
    { :field => "name", :label => "Resource", :search => true }
  end

  def self.resource_field
    { :field => "resource", :label => "Resource", :search => true }
  end

  def self.identifier_field
    { :field => "identifier", :label => "Feature", :search => true }
  end

  def self.vendor_field
    { :field => "comment", :label => "Vendor", :search => true }
  end

  def self.resources_fields
    [id_field, resource_field, checkouts_field, link_field(:link_proc => "resource_path")]
  end

  def self.executable_fields
    [id_field, identifier_field, vendor_field, resource_field, checkouts_field, link_field(:link_proc => "executable_path")]
  end

  def self.purchase_fields
    [{ :field => "num_packages", :label => "# Software Packages", :search => false},
      fy_10_field,
      fy_11_field,
      fy_12_field,
      fy_13_field]
  end

  def save_report_option(option)
    if not params[option].nil?
      session["last_#{option}".to_sym] = params[option]
    end
  end

  def save_report_options
    [:from, :to, :exclude_employees, :limit_users].each do |option|
      save_report_option option
    end
  end

  before_filter :set_parent

  protected

  def set_parent
    [User, Resource, Executable, Department, Group, College].each do |parent_type|
      parent_type_name = parent_type.name
      parent_var_name = parent_type_name.downcase

      id_param = "#{parent_type_name.downcase}_id".to_sym
      parent_id = params[id_param]
      unless parent_id.blank?
        instance_variable_set "@#{parent_var_name}".to_sym, parent_type.find(parent_id)
      end
    end
  end

  def set_user
    user_id = params[:user_id]
    @user = User.find(user_id)
  end

  def set_resource
    resource_id = params[:resource_id]
    @resource = Resource.find(resource_id)
  end

  def set_executable
    @executable = Executable.find(params[:executable_id])
  end

  def set_department
    @department = Department.find(params[:department_id])
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def set_college
    @college = College.find(params[:college_id])
  end

end