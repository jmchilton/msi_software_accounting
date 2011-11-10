
class ResourcesController < ApplicationController
  autocomplete :resource, :name

  FIELDS = [id_field,
            name_field,
            link_field(:link_proc => "resource_path")]

  def index
    @rows = Resource
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show Resource
  end

end
