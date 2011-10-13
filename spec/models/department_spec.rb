require "spec_helper"
require 'report_test_data'

describe Department do
  include ModelHelpers

  it_should_behave_like "read only model"

  before(:each) { setup_test_report_data }
  let(:records) { relation.all }

  describe "report" do
    before(:each) {
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

  describe "resource_report" do
    let(:relation) { Department.resource_report(report_test_resource.id) }

    it "should have record for group using resource" do
      find_record { |record| record.name == ReportTestData::DEPARTMENT_ONE_NAME }.should_not be_nil
    end

    it "should not have record for group not using resource" do
      find_record { |record| record.name == ReportTestData::DEPARTMENT_NO_USE }.should be_nil
    end

  end



end