require 'basic_model'

class EventType
  include BasicModel

  attr_accessor :id, :feature, :vendor, :resource_id

  def self.to_event_type(event)
    EventType.new({:id => event.evid, :feature => event.feature, :vendor => event.vendor, :resource_id => event.resource_id})
  end
``
  def self.all 
    event_types.all.map {|event| to_event_type(event) }
  end

  def self.find(id)
    to_event_type(event_types.find_by_evid(id))
  end

  def update_resource(new_resource_id) 
    if resource_id.blank? 
      executable = Executable.new({:identifier_type => 1, :comment => vendor, :identifier => feature, :rid => new_resource_id})
      if executable.save
        true
      else 
        @errors = executable.errors
        false
      end 
    else 
      false
    end
  end

  def to_param
    id.to_s
  end


  private
  def self.event_types
    Event.select("feature, vendor, min(evid) as evid, (select rid from executable where identifier = feature) as resource_id").group("feature, vendor").order("evid")
  end


end
