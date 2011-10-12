require "spec_helper"
require 'report_test_data'

describe Group do
  describe "report" do
    before(:each) {
      ReportTestData.setup_medical_resources_and_events
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
      @records.find { |record| record.name == group_name }
    end

  end

end