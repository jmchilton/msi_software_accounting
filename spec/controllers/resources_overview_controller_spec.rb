require 'spec_helper'


describe ResourcesOverviewController do
  include OverviewHelpers

  describe "show" do
    before(:each) {
      Resource.should_receive(:find).with(1).and_return(summary_double("resource", {:name => "Gaussian"}))
      get :show, :id => 1, :data_source => data_source, :format => format
    }

    describe "flexlm" do
      let(:data_source) { "flexlm"}

      it_should_behave_like "controller showing overview"
    end

    describe "collectl" do
      let(:data_source) { "collectl" }

      it_should_behave_like "controller showing overview"
    end

    describe "module" do
      let(:data_source) { "module"}

      it_should_behave_like "controller showing overview"
    end

  end

end
