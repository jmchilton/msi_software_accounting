require 'spec_helper'

describe Resource do

  describe "report" do
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
      Resource.report('2011-09-01', '2011-09-02').find_by_id(3).num_users.should == 1
    end

    it "should not find records for events after range" do
      Resource.report("2011-09-05", "").find_by_id(3).should be_blank
    end

    it "should not find records for events before range" do
      Resource.report(nil, "2011-08-04").find_by_id(3).should be_blank
    end

  end

  it "should have msi_db_link" do
    resource = FactoryGirl.create(:resource)
    resource.msi_db_link.should == "#{StaticData::MSIDB_CRUD_URL}sw/resource/#{resource.id}/view"
  end

end
