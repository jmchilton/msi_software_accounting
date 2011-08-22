require 'spec_helper'
require 'controllers/table_helpers'

describe ResourcesController do
  include TableHelpers

  describe "GET index" do
    before(:each) {
      get :index
    }

    specify { it_should_respond_successfully }
    specify { it_should_setup_table_variables }
    specify { it_should_paginate }
  end

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

  it_should_behave_like "standard GET index"

  describe "GET report" do
    before(:each) { get 'report' }

    specify { it_should_respond_successfully }
  end

  describe "GET show_report" do
    before(:each) { get 'show_report' }

    specify { it_should_respond_successfully_with_report }
    specify { it_should_assign_links_with "resources_usage_report_path" }

  end

end