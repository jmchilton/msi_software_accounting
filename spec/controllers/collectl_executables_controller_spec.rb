require 'spec_helper'

describe CollectlExecutablesController do
  include TableHelpers

  before(:each) {
    setup_parent_resource
  }

  def valid_attributes
    {}
  end

  it_should_behave_like "standard model GET index"

end
