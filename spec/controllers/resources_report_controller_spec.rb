require 'spec_helper'

describe ResourcesReportController do
  include TableHelpers

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      stub_report_method(Resource, :report)
    }

    it_should_behave_like "standard report GET index"
  end

end
