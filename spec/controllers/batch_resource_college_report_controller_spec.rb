require 'spec_helper'
require 'tempfile'

describe BatchResourceReportController do
  include TableHelpers
  include UsageReportHelpers


  describe "new" do

  end


  describe "index" do
    let (:row_relation) { test_relation_for_fields(subject_fields) }
    let(:resource1) { FactoryGirl.create(:resource, :name => "resource1") }
    let(:resource2) { FactoryGirl.create(:resource, :name => "resource2") }

    before(:each) {
      stub_resource_report_method(College, resource1)
      stub_resource_report_method(College, resource2)
      get :index, :resource_name => "resource1,resource2", :model_type => "college"
    }

    it "should render a zip file" do
      response.headers['Content-Type'].should include('application/zip')
    end

    it "should contain file for each resource" do
      with_body_as_zip do |path|
        Zippy.list(path).should include('resource1.csv', 'resource2.csv')
      end
    end


    def with_body_as_zip
      Tempfile.open('zippytestzip') do |file|
        file.write response.body
        file.rewind
        yield file.path
      end

    end

  end

end