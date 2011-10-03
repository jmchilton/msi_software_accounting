require 'spec_helper'

describe User do

  describe "msi_db_link" do
    specify {
      user = FactoryGirl.create(:user)
      user.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/user/#{user.id}/view"
    }
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
