require 'controllers/helpers'

describe DepartmentsController do
  include Helpers

  it_should_behave_like "standard GET index"
  it_should_behave_like "standard GET show", lambda { FactoryGirl.create(:department) }

end