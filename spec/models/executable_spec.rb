require 'spec_helper'

def setup_medical_resources_and_events
  resource = FactoryGirl.create(:resource)

  group1 = FactoryGirl.create(:group)
  group2 = FactoryGirl.create(:group)

  user1 = FactoryGirl.create(:user, :group => group1)
  user2 = FactoryGirl.create(:user, :group => group1)
  user3 = FactoryGirl.create(:user, :group => group2)

  exec1 = FactoryGirl.create(:executable, :identifier => "id1",  :resource => resource)
  exec2 = FactoryGirl.create(:executable, :resource => resource)
  exec_unused = FactoryGirl.create(:executable, :resource => resource)

  event1_1 = FactoryGirl.create(:event, :process_user => user1, :executable => exec1)
  event1_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec1)
  event1_3 = FactoryGirl.create(:event, :process_user => user3, :executable => exec1)
  event2_2 = FactoryGirl.create(:event, :process_user => user2, :executable => exec2)

  [exec1, exec2, exec_unused]
end


describe Executable do
  include ModelHelpers

  describe "report" do
    before(:each) {
      executables = setup_medical_resources_and_events
      relation = Executable.flexlm_report_for_resource(executables[0].resource.id)
      @records = relation.all
      @record1 = @records.find { |record| record.id == executables[0].exid }
      @record2 = @records.find { |record| record.id == executables[1].exid }
    }

    it "should have two records" do
      @records.length.should == 2
    end

    it "should have a number of users" do
      @record1[:num_users].should == 3
      @record2[:num_users].should == 1
    end

    it "should have a number of groups" do
      @record1[:num_groups].should == 2
      @record2[:num_groups].should == 1
    end

    it "should have feature name" do
      @record1[:name].should == "id1"
    end

  end

end