require 'controllers/helpers'

describe GroupsController do
  include Helpers

  it_should_behave_like "standard GET index"
  it_should_behave_like "standard GET show", lambda {
    FactoryGirl.create(:group)
    #event = FactoryGirl.create(:event)
    #Event.stub!(:find).with(event.to_param).and_return(event)
    #event
  }

end