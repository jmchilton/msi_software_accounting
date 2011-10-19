require 'spec_helper'
require 'report_test_data'

describe Executable do
  include ModelHelpers

  describe "report" do
    let(:relation) { Executable.flexlm_report_for_resource(resource_id,  report_options) }

    describe "excludes_employees option" do
      let(:resource_id) { Resource.find_by_name(ReportTestData::TECH_RESOURCE_NAME).id }
      let(:tech_record) { record_with_name ReportTestData::TECH_EXECUTABLE_IDENTIFIER }

      it_should_behave_like "resource report that can exclude employees"


    end


    describe "default options" do
      let(:report_options) { {} }

      let(:resource_id) {
        @executables = ReportTestData.setup_medical_resources_and_events
        @executables[0].resource.id
      }

      before(:each) {
        @record1 = records.find { |record| record.id == @executables[0].exid }
        @record2 = records.find { |record| record.id == @executables[1].exid }
      }

      it "should have two records" do
        records.length.should == 2
      end

      it "should have a number of users" do
        @record1[:num_users].should == 3
        @record2[:num_users].should == 1
      end

      it "should have a number of groups" do
        @record1[:num_groups].should == 2
        @record2[:num_groups].should == 1
      end

      it "should have feature name" do
        @record1[:name].should == "id1"
      end

    end

  end
end