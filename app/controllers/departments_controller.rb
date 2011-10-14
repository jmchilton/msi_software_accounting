class DepartmentsController < ApplicationController
  TITLE = "Departments"
  FIELDS = [id_field, name_field, link_field(:link_proc => "department_path")]

  def index
    @rows = Department
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show Department
  end

end
