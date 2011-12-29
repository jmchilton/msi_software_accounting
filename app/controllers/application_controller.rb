require 'time_flot'

class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery

  before_filter :set_enable_javascript
  before_filter :set_parent

  protected

  def from_date
    Date.parse(params[:from]) unless params[:from].blank?
  end

  def to_date
    Date.parse(params[:to]) unless params[:to].blank?
  end

  def set_filename filename
    headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
  end

  def set_enable_javascript
    if params[:enable_javascript].blank?
      params[:enable_javascript] = session[:enable_javascript]
    else
      session[:enable_javascript] = params[:enable_javascript]
    end
  end

  def find_and_show(model_class, instance_variable_name = nil)
    if instance_variable_name.nil?
      instance_variable_name = "@#{model_class.name.downcase}".to_sym
    end
    object = model_class.find(params[:id])
    instance_variable_set instance_variable_name, object
    show_object(object)
  end

  def show_object(object)
    respond_to do |format|
      format.html
      format.xml  { render :xml => object }
    end
  end

  def selected_resources
    param_resource_names.collect { |resource_name| Resource.find_by_name resource_name }
  end

  def selected_resource(resource_name = params[:resource_name])
    if resource_name.blank?
      nil
    else
      unescaped_resource_name = (resource_name.gsub /\\,/, ",")
      Resource.find_by_name unescaped_resource_name
    end
  end

  def param_resource_names
    resource_names = params[:resource_name]
    resource_names.gsub! /\\,/, "COMMA" # Replace escaped comma, so we can split on comma
    resource_names.split(",").collect { |escaped_name| escaped_name.gsub /COMMA/, ","}
  end

  def set_parent
    [User, Resource, Department, Group, College, Executable, CollectlExecutable].each do |parent_type|
      parent_type_name = parent_type.name
      parent_var_name = parent_type_name.gsub(/(.)([A-Z])/,'\1_\2').downcase

      id_param = "#{parent_var_name}_id".to_sym
      parent_id = params[id_param]
      unless parent_id.blank?
        instance_variable_set "@#{parent_var_name}".to_sym, parent_type.find(parent_id)
      end
    end
  end

end
