class ExecutableOverviewController < ApplicationController

  def show
    @executable = Executable.find(params[:id])
    @summary = @executable.summarize
  end

end