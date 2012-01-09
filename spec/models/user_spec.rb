require 'spec_helper'

describe User do
  include ModelHelpers

  INDEX_TEST_PERSON_LAST_NAME = "index TEST LAST NAME"
  INDEX_TEST_PERSON_FIRST_NAME = "index TEST FIRST NAME"
  INDEX_TEST_GROUP_NAME = "index group name"
  INDEX_TEST_USERNAME = "testuserindex"
  INDEX_TEST_EMAIL = "index test email"

  describe "msi_db_link" do
    specify {
      user = FactoryGirl.create(:user)
      user.msi_db_link.should == "https://www.msi.umn.edu/db/rdgc/people/user/#{user.id}/view"
    }
  end

  describe "index" do
    before(:each) {
      person = FactoryGirl.create(:person, :last_name => INDEX_TEST_PERSON_LAST_NAME,
                                           :first_name => INDEX_TEST_PERSON_FIRST_NAME,
                                           :email => INDEX_TEST_EMAIL)
      group = FactoryGirl.create(:group, :name => INDEX_TEST_GROUP_NAME)
      FactoryGirl.create(:user, :username => INDEX_TEST_USERNAME, :person => person, :group => group)
    }

    let(:records) { User.index}
    let(:test_record) { record_for records, INDEX_TEST_USERNAME }

    specify { test_record.email.should eql(INDEX_TEST_EMAIL) }
    specify { test_record.last_name.should eql(INDEX_TEST_PERSON_LAST_NAME) }
    specify { test_record.first_name.should eql(INDEX_TEST_PERSON_FIRST_NAME) }
    specify { test_record.username.should eql(INDEX_TEST_USERNAME) }
    specify { test_record.group_name.should eql(INDEX_TEST_GROUP_NAME)}

  end

  describe "executables_report" do

    describe "default options" do
      before(:each) { setup_test_report_data }
      let(:relation) { User.find_by_username(ReportTestData::USERNAME_1).executables_report( {:data_source => :flexlm} ) }

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

  end

  let(:tech_record) { find_record { |record| record.username == ReportTestData::TECH_USERNAME } }
  let(:non_tech_record) { find_record { |record| record.username == ReportTestData::NON_TECH_USERNAME } }

  describe "executable_report" do
    let(:relation) { User.executable_report(executable_id, report_options) }

    it_should_behave_like "flexlm report that can exclude employees"
  end

  describe "resource_report" do
    let(:relation) { User.resource_report(resource_id, report_options) }

    it_should_behave_like "flexlm report that can exclude employees"
    it_should_behave_like "collectl report that can exclude employees"
  end

  def record_for(records, username)
    records.find { |record| record.username == username}
  end



end
