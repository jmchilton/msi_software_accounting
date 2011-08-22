require 'spec_helper'
require 'controllers/table_helpers'

describe ResourceUserReportController do
  include TableHelpers
  render_views

  before(:each) {
    @resource = FactoryGirl.create(:resource)
  }

  let (:index_params) { {:resource_id => @resource.id} }
  let (:expected_fields) { ResourceUserReportController::FIELDS }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      User.stub(:resource_report).with(@resource.id, expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

  describe "GET 'show_usage_report'" do
    before(:each) { get 'index', :resource_id => "1" }

    specify { it_should_respond_successfully_with_report }
    specify { assigns(:resource).id.should == 1 }
    specify { it_should_assign_links_with "user_path" }
  end

end
