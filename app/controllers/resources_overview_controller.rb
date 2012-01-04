class ResourcesOverviewController < ApplicationController

  def show
    resource = Resource.find(params[:id])
    @name = resource.name
    @summary = resource.summarize(data_source)
    @data_source = data_source
    render :template => "data_source_overview/show"
  end

end