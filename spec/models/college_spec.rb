require 'spec_helper'
require 'report_test_data'
require 'aliased_sql'

describe College do
  include ModelHelpers

  it_should_behave_like "read only model"

  describe "msi_db_link" do
    specify {
      college = FactoryGirl.create(:college)
      college.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/college/#{college.id}/view"
    }
  end

  let(:tech_record) { record_with_name ReportTestData::TECH_COLLEGE_NAME  }
  let(:non_tech_record) { record_with_name ReportTestData::NON_TECH_COLLEGE_NAME  }

  describe "resource_report" do
    let(:relation) { College.resource_report(resource_id, report_options) }

    describe "default options" do
      before(:each) { setup_test_report_data }
      let(:resource_id) { report_test_resource.id }
      let(:report_options) { {:data_source => :flexlm} }


      it "has record for groups using resource" do
        should_have_record_with_name ReportTestData::COLLEGE_ONE_NAME
      end

      it "has no record for group not using resource" do
        should_not_have_record_with_name ReportTestData::COLLEGE_NO_USE
      end

    end

    it_should_behave_like "report that can exclude employees for any data source"

  end

  describe "excutable_report" do
    let(:relation) { College.executable_report(executable_id, report_options) }

    it_should_behave_like "report that can exclude employees for any data source"

  end

  describe "resources_report" do
    let(:relation) { College.find_by_name(ReportTestData::TECH_COLLEGE_NAME).resources_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "resource report that can exclude employees for any data source"
  end

  describe "executables_report" do
    let(:relation) { College.find_by_name(ReportTestData::TECH_COLLEGE_NAME).executables_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "resource report that can exclude employees for any data source"
  end

  # TODO: Extract to_aliased_sql code into a plugin
  describe "to_aliased_sql" do
    let(:aliased_sql) { College.resources({:data_source => :flexlm}).to_aliased_sql("cool_bean") }

    it "should be equivalent to normal sql" do
      College.find_by_sql(aliased_sql).should eql(College.resources(:data_source => :flexlm).all)
    end

    it "should specify a name in the from" do
      aliased_sql.should match /FROM\s+\"?colleges\"?\s+\"?cool_bean\"?/
    end

    it "should specify name in the select statement" do
      aliased_sql.should match "cool_bean.id"
    end

  end

  describe "report" do
    describe "excluding_employees_option" do
      let(:relation) { College.report( report_options ) }

      let(:tech_record) { college_record(ReportTestData::TECH_COLLEGE_NAME) }
      let(:non_tech_record) { college_record(ReportTestData::NON_TECH_COLLEGE_NAME) }

      it_should_behave_like "report that can exclude employees for any data source"
    end

  end

  def college_record(name)
    record_with_name name
  end

end

