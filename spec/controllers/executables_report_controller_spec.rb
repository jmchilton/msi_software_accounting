require 'spec_helper'

describe ExecutablesReportController do
  include TableHelpers

  before(:each) {
    @resource = FactoryGirl.create(:resource)
  }

  let (:index_params) { {:resource_id => @resource.id} }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do

    before(:each) {
      Executable.stub(:flexlm_report_for_resource).with(@resource.id, expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

  specify { it_should_assign_links_with "executable_path" }
end