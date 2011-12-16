require 'spec_helper'


describe ResourcesOverviewController do
  describe "show" do

    describe "as html" do

      it "should render earliest data date" do
        resource_double = double("resource", :name => "Gaussian", :summarize => {:count => 5, :first => '2011-08-05 12:10:38', :last => '2011-08-05 12:10:38' })
        Resource.should_receive(:find).with(1).and_return(resource_double)
        get :show, :id => 1, :data_source => "flexlm"
      end

    end

  end
end
