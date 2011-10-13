class UsersController < ReportController
  TITLE = "Users"
  FIELDS = [id_field, username_field, link_field(:link_proc => "user_path")]

  # TODO: Join people information
  def index
    @rows = User
    handle_search_criteria :username
    respond_with_table
  end

  def show
    find_and_show User
  end

end
