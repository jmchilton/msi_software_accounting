require 'spec_helper'
require 'report_test_data'

describe Executable do
  include ModelHelpers
  include HasSummary

  describe "summarize" do
    let(:instance) { FactoryGirl.create(:executable) }

    before(:each) {
      FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-05 12:10:38')
      FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-06 12:10:38')
      FactoryGirl.create(:event, :feature => instance.identifier, :ev_date => '2011-08-07 12:10:38')
    }

    it_should_behave_like "has summary"
  end

  describe "report" do
    let(:relation) { Executable.flexlm_report_for_resource(resource_id,  report_options) }


    describe "excludes_employees option" do
      let(:resource_id) { Resource.find_by_name(ReportTestData::TECH_RESOURCE_NAME).id }
      let(:tech_record) { record_with_name ReportTestData::TECH_EXECUTABLE_IDENTIFIER }

      it_should_behave_like "flexlm resource report that can exclude employees"

    end

    describe "limit_users option" do
      let(:resource_id) { Resource.find_by_name(ReportTestData::USED_TWICE_RESOURCE_NAME) }

      let(:non_tech_record) { record_with_name ReportTestData::NON_TECH_EXECUTABLE_IDENTIFIER }
      let(:tech_record) { record_with_name ReportTestData::TECH_EXECUTABLE_IDENTIFIER }

      before(:each) { ReportTestData.setup_two_executables }

      it_should_behave_like "flexlm report that can limit users"
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