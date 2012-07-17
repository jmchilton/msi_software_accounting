class RawCollectlExecutablesController < TableController

  FIELDS =
    [id_field("executable"),
     { :field => "executable", :label => "Executable", :search => true },
     { :field => "the_count", :label => "Count", :search => false }
    ]


  def index
    @multi_select = true
    @selection_handler = "moo"
    @rows = RawCollectlExecution.unmapped_distinct(params[:executable])
    respond_with_table(false)
  end

  def create
    executables = params[:executables].split(",")
    executables.each do |executable|
      instance = CollectlExecutable.new(:name => executable, :resource => selected_resource)
      instance.save
    end
    redirect_to(raw_collectl_executables_path, :notice => "Executables saved")    
  end

end
