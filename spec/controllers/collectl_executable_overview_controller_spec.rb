require 'spec_helper'


describe CollectlExecutableOverviewController do
  describe "show" do

    describe "as html" do

      it "should render earliest data date" do
        collectl_executable_double = double("collectl_executable", :name => "/bin/path", :summarize => {:count => 5, :first => '2011-08-05 12:10:38', :last => '2011-08-05 12:10:38' })
        CollectlExecutable.should_receive(:find).with(1).and_return(collectl_executable_double)
        get :show, :id => 1
      end

    end

  end
end
