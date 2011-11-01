require 'spec_helper'

describe Resource do
  include ModelHelpers

  it_should_behave_like "read only model"

  describe "report" do
    let(:relation) { Resource.report(report_options) }

    let(:non_tech_record) { record_with_name ReportTestData::NON_TECH_RESOURCE_NAME }
    let(:tech_record) { record_with_name ReportTestData::TECH_RESOURCE_NAME }

    before(:each) { ReportTestData.setup_two_resources }

    describe "excludes_employees option" do
      it_should_behave_like "report that excludes employees"
      it_should_behave_like "report that does not exclude employees"
    end

    describe "limit_users options" do
      it_should_behave_like "report that can limit users"
    end

  end


  describe "report with fixtures" do #deprecated
    let(:record1) { Resource.report.find_by_id(1)  }

    it "should include correct purchase totals" do
      record1.fy11.should eql(20)
      record1.fy10.should == 10 
      record1.fy12.should == 25 
      record1.fy13.should == 0 
    end

    it "should include resource name" do
      record1.name.should == "resource_1"
    end

    it "should find records in range" do
      Resource.report(:from => '2011-09-01', :to => '2011-09-02').find_by_id(3).num_users.should == 1
    end

    it "should not find records for events after range" do
      Resource.report(:from => "2011-09-05", :to => "").find_by_id(3).should be_blank
    end

    it "should not find records for events before range" do
      Resource.report(:from => nil, :to => "2011-08-04").find_by_id(3).should be_blank
    end

  end

  it "should have msi_db_link" do
    resource = FactoryGirl.create(:resource)
    resource.msi_db_link.should == "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{resource.id}/view"
  end

end
