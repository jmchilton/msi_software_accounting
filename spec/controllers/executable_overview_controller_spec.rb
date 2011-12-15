require 'spec_helper'


describe ExecutableOverviewController do
  describe "show" do
    let(:executable) { FactoryGirl.create(:executable)}

    describe "as html" do

      it "should render earliest data date" do
        executable_double = double("executable", :identifier => "Executable Name", :summarize => {:count => 5, :first => '2011-08-05 12:10:38', :last => '2011-08-05 12:10:38' })
        Executable.should_receive(:find).and_return(executable_double)
        get :show, :id => executable.exid
      end

    end

  end
end
