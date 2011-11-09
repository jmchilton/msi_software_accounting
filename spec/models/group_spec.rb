require "spec_helper"
require 'report_test_data'

describe Group do
  include ModelHelpers

  before(:each) { setup_test_report_data }
  let(:records) { relation.all }

  describe "report" do
    let(:relation) { Group.report(report_options) }

    describe "default options" do
      let(:record1) { record_with_name ReportTestData::GROUP_ONE_NAME }
      let(:report_options) { {} }

      it "should sum purchase data of used resources" do
        record1[:fy10].should eql(200)
      end

      it "not records for unused resources" do
        group_record_unused = record_with_name ReportTestData::GROUP_NO_USE
        group_record_unused.should be_nil
      end

    end


    let(:tech_record) { find_record { |record| record.name == ReportTestData::TECH_GROUP_NAME } }
    let(:non_tech_record) { find_record { |record| record.name == ReportTestData::NON_TECH_GROUP_NAME } }

    it_should_behave_like "flexlm report that can exclude employees"
  end


  let(:tech_record) { find_record { |record| record.group_name == ReportTestData::TECH_GROUP_NAME } }
  let(:non_tech_record) { find_record { |record| record.group_name == ReportTestData::NON_TECH_GROUP_NAME } }

  describe "resource_report" do
    let(:relation) { Group.resource_report(resource_id, report_options) }

    describe "default options" do
      let(:resource_id) { report_test_resource.id }
      let(:report_options) { {} }

      it "should have record for group using resource" do
        should_have_record  { |record| record.group_name == ReportTestData::GROUP_ONE_NAME }
      end

      it "should not have record for group not using resource" do
        should_not_have_record { |record| record.group_name == ReportTestData::GROUP_NO_USE }
      end
    end

    it_should_behave_like "flexlm report that can exclude employees"
    it_should_behave_like "collectl report that can exclude employees"

  end

  describe "resources_report" do
    let(:relation) { Group.find_by_name(ReportTestData::TECH_GROUP_NAME).resources_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "flexlm resource report that can exclude employees"
    it_should_behave_like "collectl resource report that can exclude employees"
  end

  describe "executable_report" do
    let(:relation) { Group.executable_report(executable_id, report_options) }

    it_should_behave_like "flexlm report that can exclude employees"
  end

  describe "msi_db_link" do
    specify {
      group = FactoryGirl.create(:group)
      group.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/group/#{group.id}/view"
    }
  end


end