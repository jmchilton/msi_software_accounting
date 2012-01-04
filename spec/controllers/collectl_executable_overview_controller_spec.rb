require 'spec_helper'


describe CollectlExecutableOverviewController do
  include OverviewHelpers

  describe "show" do
    before(:each) {
        CollectlExecutable.should_receive(:find).with(1).and_return(summary_double("collectl_executable", {:name => "/bin/path"}))
    }

    let(:data_source) { "collectl" }

    it_should_behave_like "controller that can show overview"
  end

end
