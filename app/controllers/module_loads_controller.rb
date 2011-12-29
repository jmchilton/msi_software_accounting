class ModuleLoadsController < ApplicationController

  def create
    @module_load = ModuleLoad.new(params[:module_load])
    if @module_load.save
      render :xml => @module_load, :status => :created
    else
      render :xml => @module_load.errors, :status => :unprocessable_entity
    end
  end

end