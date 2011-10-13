class GroupsController < ApplicationController
  TITLE = "Groups"
  FIELDS = [id_field, name_field, link_field(:link_proc => "group_path")]

  def index
    @rows = Group
    handle_search_criteria :name
    respond_with_table
  end


  def show
    @group = Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @group }
    end
  end

end
