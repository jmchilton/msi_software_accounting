require "spec_helper"
require 'report_test_data'

describe Group do
  include ModelHelpers

  before(:each) { setup_test_report_data }
  let(:records) { relation.all }

  describe "report" do
    let(:relation) { Group.report() }

    before(:each) {
      @record1 = group_record ReportTestData::GROUP_ONE_NAME
    }

    it "should sum purchase data of used resources" do
      @record1[:fy10].should eql(200)
    end

    it "should not sum purchases of unused resources" do
      group_record_unused = group_record ReportTestData::GROUP_NO_USE
      group_record_unused[:fy10].should be_nil
    end

    def group_record(group_name)
      find_record { |record| record.name == group_name }
    end

  end

  describe "resource_report" do
    let(:relation) { Group.resource_report(report_test_resource.id) }

    it "should have record for group using resource" do
      find_record { |record| record.group_name == ReportTestData::GROUP_ONE_NAME }.should_not be_nil
    end

    it "should not have record for group not using resource" do
      find_record { |record| record.group_name == ReportTestData::GROUP_NO_USE }.should be_nil
    end

  end

  describe "msi_db_link" do
    specify {
      group = FactoryGirl.create(:group)
      group.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/group/#{group.id}/view"
    }
  end


end