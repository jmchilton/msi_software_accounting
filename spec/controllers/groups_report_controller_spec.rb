require 'spec_helper'

describe GroupsReportController do
  include TableHelpers

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      stub_report_method(Group, :report)
    }

    it_should_behave_like "standard report GET index"
  end

end
