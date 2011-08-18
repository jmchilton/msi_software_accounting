require 'spec_helper'
require 'controllers/table_helpers'

describe ResourcesController do
  include TableHelpers

  describe "GET index" do
    before(:each) {
      get :index
    }
    specify { it_should_setup_table_variables }
    specify { it_should_paginate }
    specify { response.should be_success }

  end

  describe "json GET index" do
    before(:each) {
      get :index, :format => :json, :page => 1, :rows => 2
    }

    it "should include page" do
      json_response["page"].to_s.should == "1"
    end

    it "should include total" do
      json_response["total"].to_s.should == "2"
    end

    it "should include cells" do
      json_response["rows"].count.should == 2
    end

    it "should have cells with one value for each field" do
      json_response["rows"][0]["cell"].count.should == assigns[:fields].count
    end

  end

  describe "GET 'show_usage_report'" do
    before(:each) { put 'show_usage_report', :id => "1" }

    specify { response.should be_success }
    specify { it_should_setup_table_variables }

  end

  describe "GET 'usage_report'" do
    before(:each) { get 'usage_report', :id => "1" }
    
    specify { response.should be_success }

  end

  describe "GET 'show_usage_report'" do
    before(:each) { get 'show_usage_report', :id => "1" }

    specify { response.should be_success }
    specify { it_should_setup_table_variables }
    specify { it_should_not_paginate }

  end

end