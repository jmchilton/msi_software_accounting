require 'spec_helper'

describe ExecutablesPlotController do
  before(:each) {
    @snapshot = FactoryGirl.create(:flexlm_app_snapshot)
    @executable = @snapshot.executable
  }

  describe "GET 'new'" do
    it "should be successful" do
      get 'new', :executable_id => @executable.exid
      response.should be_success
    end
  end

  describe "GET 'index'" do

    it "should be successful" do
      get 'index', :executable_id => @executable.exid
      response.should be_success
    end

  end

end
