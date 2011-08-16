require 'controllers/helpers'

describe EventsController do
  include Helpers

  it_should_behave_like "standard GET index"
  it_should_behave_like "standard GET show", lambda {
    event = FactoryGirl.create(:event)
    Event.stub!(:find).with(event.to_param).and_return(event)
    event
  }

end