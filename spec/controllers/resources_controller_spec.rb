require 'spec_helper'

describe ResourcesController do

  describe "GET index" do

    it "sets table parameters" do
      get :index
      assigns(:rows).should be_an Array
      assigns(:fields).should be_an Array
      assigns(:title).should be_a String
    end

  end

  describe "GET 'show_usage_report'" do
    it "should be successful" do
      get 'show_usage_report', :id => "1"
      response.should be_success
    end
  end

  describe "GET 'usage_report'" do
    it "should be successful" do
      get 'usage_report', :id => "1"
      response.should be_success
    end
  end

end
