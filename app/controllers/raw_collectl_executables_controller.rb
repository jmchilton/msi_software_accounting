class RawCollectlExecutablesController < TableController

  FIELDS =
    [{ :field => "executable", :label => "Executable", :search => true },
     { :field => "the_count", :label => "Count", :search => false }
    ]


  def index
    @rows = RawCollectlExecution.unmapped_distinct(params[:executable])
    respond_with_table(false)
  end

end
