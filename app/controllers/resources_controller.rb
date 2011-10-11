
class ResourcesController < ApplicationController
  autocomplete :resource, :name

  FIELDS = [id_field,
            name_field,
            link_field(:link_proc => "resource_path")]
  TITLE = "Resources"

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Resource
    if perform_search?
      @rows = @rows.where("name like ?", "%#{params[:name]}%")
    end
    respond_with_table
  end

  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

end
