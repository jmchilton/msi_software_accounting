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
    @fields << link_field(:link_proc => lambda  { |id| resource_mappable_path(id, :resource_id => @resource.id) })

    @rows = @mappable_class.where "resource_id = ?", @resource.id
    handle_search_criteria :name
    respond_with_table
  end

  def show
    find_and_show(@mappable_class, :@instance, {:template => mappable_view(:show) })
  end

  def new
    @instance = @mappable_class.new(:resource => @resource)
    show_object(@instance, {:template => mappable_view(:new) })
  end

  def create
    @instance = @mappable_class.new(:name => params[:collectl_executable][:name], :resource => Resource.find(params[:collectl_executable][:resource_id]))
    if @instance.save
      redirect_to(resource_mappables_path(:resource_id => @resource.id), :notice => 'Collectl Executable was successfully created.')
    else
      render :template => mappable_view(:new)
    end
  end


  def destroy
    @instance = @mappable_class.find(params[:id])
    @instance.destroy
    redirect_to(resource_mappables_url(:resource_id => @resource.id))
  end

  private

  def mappable_view(action)
    "#{@mappable_type}s/#{action}"
  end

  def set_resource
    @resource = Resource.find params[:resource_id]
  end

  def set_mappable_class
    if params[:mappable_type].blank?
      params[:mappable_type] = "collectl_executable"
    end
    @mappable_type = params[:mappable_type]
    raise ArgumentError, "Unknown mappable type #{mappable_type}" unless ["collectl_executable", "module"].find_index(@mappable_type)
    if @mappable_type == "collectl_executable"
      @mappable_class = CollectlExecutable
    else
      @mappable_class = Module
    end
  end

end


