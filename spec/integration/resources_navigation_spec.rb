require 'spec_helper'
#require 'integration/integration_helpers'

describe "Navigating Resources" do
  include IntegrationHelpers

  describe "show links" do
    before(:each) {
      @resource = FactoryGirl.create(:resource)
      visit resource_path(@resource)
    }

    specify { it_should_have_msi_db_link_for(@resource) }

  end

end