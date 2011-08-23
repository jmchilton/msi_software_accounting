class EventTypesController < ApplicationController
  # GET /event_types
  # GET /event_types.xml
  def index
    @event_types = EventType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @event_types }
    end
  end

  # GET /event_types/1
  # GET /event_types/1.xml
  def show
    @event_type = EventType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event_type }
    end
  end

  # GET /event_types/1/edit
  def edit
    @event_type = EventType.find(params[:id])
  end

  # PUT /event_types/1
  # PUT /event_types/1.xml
  def update
    @event_type = EventType.find(params[:id])
    respond_to do |format|
      if @event_type.update_resource(params[:resource_name])
        format.html { redirect_to(@event_type, :notice => 'Event type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event_type.errors, :status => :unprocessable_entity }
      end
    end
  end

end
