
class ResourcesController < ApplicationController
  autocomplete :resource, :name

  @@index_fields =
    [id_field,
     name_field,
     link_field(:link_proc => "resource_path")]

  @@index_title = "Resources"

  # GET /resources
  # GET /resources.xml
  def index
    @fields = @@index_fields
    @title = @@index_title
    @rows = Resource
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    respond_with_table
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

end
