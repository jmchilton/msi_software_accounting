require 'spec_helper'
#require 'controllers/helpers'

describe PeopleController do
  include Helpers

  it_should_behave_like "standard GET index"
  it_should_behave_like "standard GET show", lambda {
    FactoryGirl.create(:person)
    #event = FactoryGirl.create(:person)
    #Event.stub!(:find).with(event.to_param).and_return(event)
    #event
  }

end