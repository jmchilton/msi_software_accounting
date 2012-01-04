class ResourceMappablesController < TableController
  FIELDS = [id_field,
            {:field => "name", :label => "Name"}]

  before_filter :set_resource
  before_filter :set_mappable_class

  def table_template
    "collectl_executables/index"
  end

  def index
    @fields = Array.new(FIELDS)
    @fields << link_field(:link_proc => lambda  { |id| collectl_executable_path(id, :resource_id => @resource.id) })

    @rows = @mappable_class.where "resource_id = ?", @resource.id
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show(@mappable_class, :@collectl_executable, {:template => "collectl_executables/show" })
  end

  def new
    @collectl_executable = @mappable_class.new(:resource => @resource)
    show_object(@collectl_executable, {:template => "collectl_executables/new" })
  end

  def create
    @collectl_executable = @mappable_class.new(:name => params[:collectl_executable][:name], :resource => Resource.find(params[:collectl_executable][:resource_id]))
    if @collectl_executable.save
      redirect_to(resource_mappables_path(:resource_id => @resource.id), :notice => 'Collectl Executable was successfully created.')
    else
      render :template => "collectl_executables/new"
    end
  end

  def destroy
    @collectl_executable = @mappable_class.find(params[:id])
    @collectl_executable.destroy
    redirect_to(resource_mappables_url(:resource_id => @resource.id))
  end

  private

  def set_resource
    @resource = Resource.find params[:resource_id]
  end

  def set_mappable_class
    @mappable_class = CollectlExecutable
  end

end


