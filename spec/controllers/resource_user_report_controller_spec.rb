require 'spec_helper'
require 'controllers/table_helpers'

describe ResourceUserReportController do
  include TableHelpers

  before(:each) {
    setup_parent_resource
  }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      User.stub(:resource_report).with(resource.id, expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

end
