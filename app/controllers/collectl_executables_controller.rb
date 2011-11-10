class CollectlExecutablesController < TableController
  FIELDS = [id_field,
            {:field => lambda { |executable| executable.resource.name }, :label => "Resource"},
            {:field => "name", :label => "Name"}]

  before_filter :set_resource

  def index
    @fields = Array.new(FIELDS)
    @fields << link_field(:link_proc => lambda  { |collectl_executable_id| resource_collectl_executable_path(@resource.id, collectl_executable_id) })

    @rows = CollectlExecutable.where "resource_id = ?", @resource.id
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show(CollectlExecutable, :@collectl_executable)
  end

  def new
    @collectl_executable = CollectlExecutable.new(:resource => @resource)
    show_object(@collectl_executable)
  end

  def create
    @collectl_executable = CollectlExecutable.new(:name => params[:collectl_executable][:name], :resource => @resource)
    respond_to do |format|
      if @collectl_executable.save
        format.html { redirect_to(resource_collectl_executables_path(@resource), :notice => 'Collectl Executable was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @collectl_executable = CollectlExecutable.find(params[:id])
    @collectl_executable.destroy

    respond_to do |format|
      format.html { redirect_to(resource_collectl_executables_url(@resource)) }
    end

  end


  private

  def set_resource
    @resource = Resource.find params[:resource_id]
  end



end


