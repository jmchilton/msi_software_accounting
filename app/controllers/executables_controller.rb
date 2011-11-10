class ExecutablesController < TableController
  FIELDS = [id_field,
            {:field => lambda { |executable| executable.resource.name }, :label => "Resource"},
            {:field => "identifier", :label => "Feature"},
            {:field => "comment", :label => "Vendor"},
            link_field(:link_proc => "executable_path")]

  def index
    @rows = Executable
    handle_search_criteria :identifier
    handle_search_criteria :comment
    respond_with_table
  end

  def show
    find_and_show(Executable)
  end

  def new
    @executable = Executable.new
    show_object(@executable)
  end

  def edit
    @executable = Executable.find(params[:id])
  end

  def create
    @executable = Executable.new(params[:executable])

    respond_to do |format|
      if @executable.save
        format.html { redirect_to(@executable, :notice => 'Executable was successfully created.') }
        format.xml  { render :xml => @executable, :status => :created, :location => @executable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @executable.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @executable = Executable.find(params[:id])

    respond_to do |format|
      if @executable.update_attributes(params[:executable])
        format.html { redirect_to(@executable, :notice => 'Executable was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @executable.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @executable = Executable.find(params[:id])
    @executable.destroy

    respond_to do |format|
      format.html { redirect_to(executables_url) }
      format.xml  { head :ok }
    end
  end
end
