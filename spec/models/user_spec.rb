require 'spec_helper'

describe User do
  include ModelHelpers

  describe "msi_db_link" do
    specify {
      user = FactoryGirl.create(:user)
      user.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/user/#{user.id}/view"
    }
  end

  describe "executables_report" do
    before(:each) { setup_test_report_data }
    let(:records) { relation.all }
    let(:relation) { User.find_by_username(ReportTestData::USERNAME_1).executables_report() }

    it "should have record for executable used" do
      should_have_record { |record| record.identifier == ReportTestData::EXECUTABLE_IDENTIFIER_1 }
    end

    it "should not have record for unused executables" do
      should_not_have_record { |record| record.identifier == ReportTestData::EXECUTABLE_IDENTIFIER_NO_USE }
    end

    it "should have resource" do
      find_record { |record| record.identifier == ReportTestData::EXECUTABLE_IDENTIFIER_1 }.resource.should eql(ReportTestData::RESOURCE_NAME_1)
    end

  end

  describe "executable_report" do
     let(:report1) { User.executable_report(1) }
     let(:alices_record) { record_for(report1, 'alice') }

     it "should have record of user using feature" do
       alices_record.should_not be_blank
     end

  end

  describe "resource_report" do
    let(:report1) { User.resource_report(1) }
    let(:alices_record) { record_for(report1, 'alice') }

    it "should have record of user using software" do
      alices_record.should_not be_blank
    end

    it "should have e-mail in the record" do
      alices_record.email.should == "alice@example.com"
    end

    it "should have first name in the record" do
      alices_record.first_name.should == "Alice"
    end

    it "should have last name in the record" do
      alices_record.last_name.should == "Albert"
    end

    it "should have college in the record" do
      alices_record.college_name.should == "CPH"
    end
 
    it "should not have record of users who have not used software" do
      record_for(report1, 'bob').should be_blank
    end

    it "should find events in date range" do
      report = User.resource_report(3, {:from => '2011-09-01', :to => '2011-09-02'})
      record_for(report, "shelly").should_not be_blank
    end

    it "should not find events before date range" do
      report = User.resource_report(3, {:from => '2011-09-02', :to => '2011-09-03'})
      record_for(report, "shelly").should be_blank
    end

    it "should not find events after date range" do
      report = User.resource_report(3, {:from => '2011-06-02', :to => '2011-07-03'})
      record_for(report, "shelly").should be_blank
    end

  end

  def record_for(records, user)
    records.find { |record| record.username == user}
  end



end
