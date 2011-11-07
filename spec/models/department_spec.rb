require "spec_helper"
require 'report_test_data'

describe Department do
  include ModelHelpers

  it_should_behave_like "read only model"

  describe "report" do
    let(:relation) { Department.report(report_options) }

    describe "default options" do

      before(:each) { setup_test_report_data }
      let(:report_options) { {} }

      let(:record1) { department_record ReportTestData::DEPARTMENT_ONE_NAME }

      it "should sum purchase data of used resources" do
        record1[:fy10].should eql(200)
      end

      it "should not have records for unused resources" do
        department_record(ReportTestData::DEPARTMENT_NO_USE).should be_nil
      end

    end

    it_should_behave_like "flexlm report that can exclude employees"
  end

  describe "resources" do

    describe "excluding employees" do

      before(:each) { setup_test_used_twice_data }

      let(:relation) { Department.resources( { :exclude_employees => true } ) }

      it "departments with employees should not include usage information for these employees" do
        should_not_have_record { |record| record.id == Department.find_by_name(ReportTestData::TECH_DEPARTMENT_NAME).id }
      end

      it "departments without employees should have normal usage information" do
        should_have_record { |record| record.id == Department.find_by_name(ReportTestData::NON_TECH_DEPARTMENT_NAME).id }
      end

    end

  end



  let(:tech_record) { record_with_name ReportTestData::TECH_DEPARTMENT_NAME  }
  let(:non_tech_record) { record_with_name ReportTestData::NON_TECH_DEPARTMENT_NAME  }

  describe "resource_report" do

    let(:relation) { Department.resource_report(resource_id, report_options) }

    it_should_behave_like "flexlm report that can exclude employees"

    describe "default options" do
      before(:each) { setup_test_report_data }
      let(:resource_id) { report_test_resource.id }
      let(:report_options) { {} }

      it "should have record for group using resource" do
        should_have_record_with_name ReportTestData::DEPARTMENT_ONE_NAME
      end

      it "should not have record for group not using resource" do
        should_not_have_record_with_name ReportTestData::DEPARTMENT_NO_USE
      end
    end


  end

  describe "excutable_report" do
    let(:relation) { Department.executable_report(executable_id, report_options) }

    it_should_behave_like "flexlm report that can exclude employees"
  end

  describe "resources_report" do
    let(:relation) { Department.find_by_name(ReportTestData::TECH_DEPARTMENT_NAME).resources_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "flexlm resource report that can exclude employees"
  end

  describe "executables_report" do
    let(:relation) { Department.find_by_name(ReportTestData::TECH_DEPARTMENT_NAME).executables_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "flexlm resource report that can exclude employees"
  end

  describe "msi_db_link" do
    specify {
      department = FactoryGirl.create(:department)
      department.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/department/#{department.id}/view"
    }
  end

  def department_record(department_name)
    record_with_name department_name

  end


end