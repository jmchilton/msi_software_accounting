class CollectlExecutablesController < ApplicationController
  def autocomplete_execution_unmapped
    render :json => json_for_autocomplete(RawCollectlExecution.unmapped_distinct(params[:term]), "executable")
  end

end
