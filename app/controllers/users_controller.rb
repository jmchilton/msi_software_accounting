class UsersController < ReportController
  TITLE = "Users"
  FIELDS = [id_field, username_field, link_field(:link_proc => "user_path")]

  # TODO: Join people information
  def index
    @fields = FIELDS
    @title = TITLE
    @rows = User
    handle_search_criteria :username

    respond_with_table
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

end
