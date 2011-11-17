require 'fields'

class TableController < ApplicationController
  include TableHelper
  extend Fields
  include Fields

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