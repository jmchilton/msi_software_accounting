class ResourcesOverviewController < ApplicationController

  def show
    resource = Resource.find(params[:id])
    @name = resource.name
    data_source = params[:data_source]
    if ["flexlm", "collectl"].index(data_source).nil?
      raise "invalid data source - #{data_source}"
    end
    @summary = resource.summarize(data_source)
    render :template => "#{data_source}_overview/show"
  end

end