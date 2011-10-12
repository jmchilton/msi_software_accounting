require "spec_helper"
require 'report_test_data'

describe Group do
  before(:each) {
    ReportTestData.setup_medical_resources_and_events
  }

  describe "report" do
    before(:each) {
      relation = Group.report()
      @records = relation.all
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
    before(:each) {
      test_resource = Resource.find_by_name ReportTestData::RESOURCE_NAME_1
      relation = Group.resource_report(test_resource.id)
      @records = relation.all
    }

    it "should have record for group using resource" do
      find_record { |record| record.group_name == ReportTestData::GROUP_ONE_NAME }
    end

    it "should not have record for group not using resource" do
      find_record { |record| record.group_name == ReportTestData::GROUP_NO_USE }
    end

  end

  def find_record(&block)
    @records.find &block
  end

end