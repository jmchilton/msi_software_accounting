class EventTypesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, :with => :resource_not_found

  FIELDS =
    [id_field,
     { :field => "feature", :label => "Feature", :search => false },
     { :field => "vendor", :label => "Vendor", :search => false },
     { :field => "resource_name", :label => "Resource Name", :search => false },
     link_field(:link_proc => "edit_event_type_path")
     ]
  TITLE = "FLEXlm Event Types"

  # GET /event_types
  # GET /event_types.xml
  def index
    @fields = FIELDS
    @title = TITLE
    @rows = EventType

    respond_with_table(false)
    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @event_types }
    #end
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

  protected

  def resource_not_found
    flash[:alert] = "A resource record with the name you specified could not be found."
    redirect_to event_types_path
  end

end
