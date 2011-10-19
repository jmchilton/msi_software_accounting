require 'spec_helper'
require 'report_test_data'

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
      let(:report_options) { { } }


      it "should have record for group using resource" do
        should_have_record_with_name ReportTestData::COLLEGE_ONE_NAME
      end

      it "should not have record for group not using resource" do
        should_not_have_record_with_name ReportTestData::COLLEGE_NO_USE
      end

    end

    it_should_behave_like "report that can exclude employees"

  end

  describe "excutable_report" do
    let(:relation) { College.executable_report(executable_id, report_options) }

    it_should_behave_like "report that can exclude employees"

  end

  describe "resources_report" do
    let(:relation) { College.find_by_name(ReportTestData::TECH_COLLEGE_NAME).resources_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "resource report that can exclude employees"
  end

  describe "executables_report" do
    let(:relation) { College.find_by_name(ReportTestData::TECH_COLLEGE_NAME).executables_report(report_options) }
    let(:tech_record) { record_with_resource ReportTestData::TECH_RESOURCE_NAME }

    it_should_behave_like "resource report that can exclude employees"
  end




  describe "resources" do #deprecated
    let(:college_resources) { College.resources }
    
    specify "cfans should use 1 resource" do
      college_resources.find_by_id("1").should_not be_instance_of Array
    end

    specify "cfans should use resource 1" do 
      college_resources.find_by_id("1").rid.should eql(1)
    end
    
  end

  # TODO: Extract to_aliased_sql code into a plugin
  describe "to_aliased_sql" do
    let(:aliased_sql) { College.resources.to_aliased_sql("cool_bean") }

    it "should be equivalent to normal sql" do
      College.find_by_sql(aliased_sql).should eql(College.resources.all)
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

      it_should_behave_like "report that can exclude employees"

    end

  end

  def college_record(name)
    record_with_name name
  end

  describe "reports with fixtures" do # Deprecated

    describe "cfans report" do 
      let(:cfans_report) { College.report.first }

      it "should be sorted by resource name" do
        cfans_report.name.should eql("CFANS")
      end

      it "should use one package" do
        cfans_report.num_packages.should eql(1)
      end

      it "should contain software count" do
        cfans_report.should respond_to(:num_packages)
      end

      it "should contain total costs per year" do 
        cfans_report.should respond_to(:fy11)
      end

      it "should have 0 as 2010 cost" do
        cfans_report.fy10.should eql(10)
      end

      it "should have 20 as 2011 cost" do
        cfans_report.fy11.should eql(20) 
      end 
  
      it "should have 25 as 2012 cost" do
        cfans_report.fy12.should eql(25)
      end

      it "should have 0 as 2013 cost" do 
        cfans_report.fy13.should eql(0)
      end

    end

    describe "it report" do
      let(:it_report) { College.report.find_by_name("IT") }
  
      it "should have a cost of 10" do
        it_report.fy10.should eql(10)
      end
  
    end

    describe "pub_health report" do
      let(:cph_report) { College.report.find_by_name("CPH") }

      it "should have a cost for multiple resources" do
        cph_report.fy11.should eql(30)
      end
 
      it "should use two packages" do
        cph_report.num_packages.should eql(2)
      end

    end


  end

end

