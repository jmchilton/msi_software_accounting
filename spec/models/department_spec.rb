require "spec_helper"
require 'report_test_data'

describe Department do

  describe "report" do
     before(:each) {
      ReportTestData.setup_medical_resources_and_events
      relation = Department.report()
      @records = relation.all
      @record1 = department_record ReportTestData::DEPARTMENT_ONE_NAME
    }

    it "should sum purchase data of used resources" do
      @record1[:fy10].should eql(200)
    end

    it "should not sum purchases of unused resources" do
      department_record = department_record ReportTestData::DEPARTMENT_NO_USE
      department_record[:fy10].should be_nil
      department_record[:fy11].should be_nil
      department_record[:fy12].should be_nil
      department_record[:fy13].should be_nil
    end

    def department_record(department_name)
      @records.find { |record| record.name == department_name }
    end
  end




end