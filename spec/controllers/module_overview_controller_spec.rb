require 'spec_helper'


describe ModuleOverviewController do
  include OverviewHelpers

  describe "show" do
    before(:each) {
      SoftwareModule.should_receive(:find).and_return(summary_double("module", :name => "bowtie"))
    }

    let(:data_source) { "module" }

    it_should_behave_like "controller that can show overview"
  end

end
