require 'spec_helper'

describe ExecutableOverviewController do
  include OverviewHelpers

  describe "show" do
    before(:each) {
      Executable.should_receive(:find).and_return(summary_double("executable", :identifier => "Executable Name"))
    }

    let(:data_source) { "flexlm"}

    it_should_behave_like "controller that can show overview"

  end

end
