class ExecutablesController < ApplicationController
  FIELDS = [id_field,
            {:field => lambda { |executable| executable.resource.name }, :label => "Resource"},
            {:field => "identifier", :label => "Feature"},
            {:field => "comment", :label => "Vendor"},
            link_field(:link_proc => "executable_path")]
  TITLE = "FLEXlm Features"

  def index
    @fields = FIELDS
    @title = TITLE
    @rows = Executable
    if perform_search?
      @rows = @rows.where("identifier like ?", "%#{params[:identifier]}%").
                    where("comment like ?", "%#{params[:comment]}%")
    end
    respond_with_table
  end

  # GET /executables/1
  # GET /executables/1.xml
  def show
    @executable = Executable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @executable }
    end
  end

  # GET /executables/new
  # GET /executables/new.xml
  def new
    @executable = Executable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @executable }
    end
  end

  # GET /executables/1/edit
  def edit
    @executable = Executable.find(params[:id])
  end

  # POST /executables
  # POST /executables.xml
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

  # PUT /executables/1
  # PUT /executables/1.xml
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

  # DELETE /executables/1
  # DELETE /executables/1.xml
  def destroy
    @executable = Executable.find(params[:id])
    @executable.destroy

    respond_to do |format|
      format.html { redirect_to(executables_url) }
      format.xml  { head :ok }
    end
  end
end
