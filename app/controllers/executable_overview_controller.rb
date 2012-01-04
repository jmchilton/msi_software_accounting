class ExecutableOverviewController < ApplicationController

  def show
    executable = Executable.find(params[:id])
    @name = executable.identifier
    @summary = executable.summarize
    @data_source = "flexlm"
    render :template => 'data_source_overview/show'
  end

end