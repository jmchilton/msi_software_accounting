require 'spec_helper'
require 'controllers/table_helpers'

describe ExecutableUserReportController do
  include TableHelpers
  render_views

  before(:each) {
    @resource = FactoryGirl.create(:resource)
  }
  let (:index_params) { {:resource_id => @resource.id} }
  let (:expected_fields) { ExecutableUserReportController::EXECUTABLE_USER_REPORT_FIELDS }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do

    before(:each) {
      Executable.stub(:flexlm_report_for_resource).with(@resource.id, expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

end