require 'spec_helper'

describe CollegesReportController do
  include TableHelpers

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      stub_report_method(College, :report)
    }

    it_should_behave_like "standard report GET index"
  end

end
