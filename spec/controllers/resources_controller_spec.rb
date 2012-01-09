require 'spec_helper'

describe ResourcesController do
  include TableHelpers

  it_should_behave_like "standard model GET index"

end