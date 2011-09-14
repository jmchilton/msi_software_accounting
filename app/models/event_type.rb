require 'basic_model'

class EventType
  include BasicModel

  attr_accessor :id, :feature, :vendor, :resource_name

  def self.to_event_type(event)
    EventType.new({:id => event.evid, :feature => event.feature, :vendor => event.vendor, :resource_name => event.resource_name})
  end

  def self.all 
    event_types.all.map {|event| to_event_type(event) }
  end

  def self.find(id)
    to_event_type(event_types.find_by_evid(id))
  end

  def update_resource(new_resource_name)
    resource_id = Resource.find_by_name(new_resource_name).id
    if resource_name.blank?
      executable = Executable.new({:identifier_type => 1, :comment => vendor, :identifier => feature, :rid => resource_id})
      if executable.save
        true
      else 
        @errors = executable.errors
        false
      end 
    else
      executable = Executable.find_by_identifier_and_comment(feature, vendor)
      if executable.update_attribute(:rid, resource_id)
        true
      else
        @errors = executable.errors
        false
      end
    end
  end

  def to_param
    id.to_s
  end

  def [](attribute)
    #instance_variable_get "@#{attribute}"
    send attribute
  end

  private
  def self.event_types
    Event.select("feature, vendor, min(evid) as evid, (select name from resources inner join executable on executable.rid = resources.id where identifier = feature) as resource_name").group("feature, vendor").order("evid")
  end


end
