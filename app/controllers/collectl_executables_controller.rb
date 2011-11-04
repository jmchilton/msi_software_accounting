class CollectlExecutablesController < ApplicationController
  FIELDS = [id_field,
            {:field => lambda { |executable| executable.resource.name }, :label => "Resource"},
            {:field => "name", :label => "Name"},
            link_field(:link_proc => "collectl_executable_path")]
  #TITLE = "Collectl Executables"

  before_filter :set_resource

  def index
    @fields = FIELDS
    @title = "Collectl Executables for Resource #{@resource.name}"
    @rows = CollectlExecutable.where "resource_id = #{@resource.id}"
    handle_search_criteria :name
    respond_with_table
  end

  private

  def set_resource
    @resource = Resource.find params[:resource_id]
  end



end


