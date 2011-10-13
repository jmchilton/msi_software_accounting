class DepartmentsController < ApplicationController
  TITLE = "Departments"
  FIELDS = [id_field, name_field, link_field(:link_proc => "department_path")]

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Department
    handle_search_criteria :name
    respond_with_table
  end

  # GET /departments/1
  # GET /departments/1.xml
  def show
    @department = Department.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @department }
    end
  end

end
