class CollegesController < TableController
  TITLE = "Colleges"
  FIELDS = [id_field, name_field, link_field(:link_proc => "college_path")]

  def index
    @rows = College
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show College
  end

end
