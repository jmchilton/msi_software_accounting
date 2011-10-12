require 'spec_helper'

describe ResourcesController do
  include TableHelpers

  describe "json GET index" do
    before(:each) {
      get :index, :format => :json, :page => 1, :rows => 2
    }

    it "should include page" do
      json_response["page"].to_s.should == "1"
    end

    it "should include total" do
      json_response["total"].should_not be_blank
    end

    it "should include cells" do
      json_response["rows"].count.should == 2
    end

    it "should have cells with one value for each field" do
      json_response["rows"][0]["cell"].count.should == assigns[:fields].count
    end

  end

  it_should_behave_like "standard model GET index"

end