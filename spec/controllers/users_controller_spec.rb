require 'spec_helper'
require 'controllers/helpers'

describe UsersController do
  include Helpers

  it_should_behave_like "standard GET index"
  it_should_behave_like "standard GET show", lambda { FactoryGirl.create(:user) }

end