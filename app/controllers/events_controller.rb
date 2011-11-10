class EventsController < ApplicationController

  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end


  def show
    find_and_show Event
  end

end
