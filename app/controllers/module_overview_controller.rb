class ModuleOverviewController < ApplicationController

  def show
    software_module = SoftwareModule.find(params[:id])
    @name = software_module.name
    @summary = software_module.summarize
    @data_source = "module"
    render :template => 'data_source_overview/show'
  end

end