require 'spec_helper'

describe GroupsController do
  include TableHelpers

  it_should_behave_like "standard model GET index"
  it_should_behave_like "standard GET show", lambda { FactoryGirl.create(:group) }

end