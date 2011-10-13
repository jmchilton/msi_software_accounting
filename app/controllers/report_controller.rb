class ReportController < ApplicationController
  before_filter :set_last_date_range

  protected

  def respond_with_report
    respond_with_table(false)
  end

  def report_options
    {:from => params[:from], :to => params[:to]}
  end

  def handle_executables_search_criteria
    handle_search_criteria :resource
    handle_search_criteria :identifier
    handle_search_criteria :comment
  end



  def self.resource_field
    { :field => "resource", :label => "Resources", :search => true }
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

  def set_last_date_range
    if not params[:from].nil?
      session[:last_from] = params[:from]
    end

    if not params[:to].nil?
      session[:last_to] = params[:to]
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