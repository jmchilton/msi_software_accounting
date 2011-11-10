class UsersController < TableController
  FIELDS = [id_field, username_field, first_name_field, last_name_field, email_field, group_name_field, link_field(:link_proc => "user_path")]

  def index
    @rows = User.index
    handle_search_criteria :username
    handle_search_criteria :first_name
    handle_search_criteria :last_name
    handle_search_criteria :email
    handle_search_criteria :group_name, "groups.name"
    respond_with_table
  end

  def show
    find_and_show User
  end

end
