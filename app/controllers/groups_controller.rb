class GroupsController < ApplicationController
  TITLE = "Groups"
  FIELDS = [id_field, name_field]

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Group
    handle_search_criteria :name
    respond_with_table
  end


  # GET /groups/1
  # GET /groups/1.xml
  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

end
