class CollegesController < ReportController
  TITLE = "Colleges"
  FIELDS = [id_field, name_field, link_field(:link_proc => "college_path")]

  def index
    @rows = College
    handle_search_criteria :name
    respond_with_table
  end


  # GET /colleges/1
  # GET /colleges/1.xml
  def show
    @college = College.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @college }
    end
  end

end
