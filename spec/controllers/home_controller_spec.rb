require 'spec_helper'
#require 'controllers/helpers'

describe HomeController do
  include Helpers

  it_should_behave_like "standard GET index"

end