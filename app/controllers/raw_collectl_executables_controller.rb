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
    
  end

end
