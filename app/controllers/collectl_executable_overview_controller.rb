class CollectlExecutableOverviewController < ApplicationController

  def show
    executable = CollectlExecutable.find(params[:id])
    @name = executable.name
    @summary = executable.summarize
    render :template => 'collectl_overview/show'
  end

end