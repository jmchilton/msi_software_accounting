class CollectlExecutableOverviewController < ApplicationController

  def show
    executable = CollectlExecutable.find(params[:id])
    @name = executable.name
    @summary = executable.summarize
    @data_source = "collectl"
    render :template => 'data_source_overview/show'
  end

end