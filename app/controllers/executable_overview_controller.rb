class ExecutableOverviewController < ApplicationController

  def show
    executable = Executable.find(params[:id])
    @name = executable.identifier
    @summary = executable.summarize
    render :template => 'flexlm_overview/show'
  end

end