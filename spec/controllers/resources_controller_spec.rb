require 'spec_helper'
require 'controllers/table_helpers'

describe ResourcesController do
  include TableHelpers

  describe "GET index" do

    it "sets table parameters" do
      get :index
      it_should_setup_table_variables
    end

  end

  describe "GET 'show_usage_report'" do
    before(:each) { get 'show_usage_report', :id => "1" }

    specify { response.should be_success }

    specify { it_should_setup_table_variables }

  end

  describe "GET 'usage_report'" do
    before(:each) { get 'usage_report', :id => "1" }
    
    specify { response.should be_success }

  end

end