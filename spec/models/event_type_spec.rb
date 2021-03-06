require 'spec_helper'

describe EventType do
  let(:resource) {
    FactoryGirl.create(:resource, :name => "the_resource_name")
  }
  let(:event) {
    FactoryGirl.create(:event, :feature => "the_feature", :vendor => "the_vendor")
  }
  let(:event_type) {
    evid = event.evid
    EventType.all.find { |eventType| eventType.id == evid }
  }

  describe "all" do
    it "should contain vendor from event table" do
      event_type.vendor.should == "the_vendor"
    end

    it "should take smallest id from event table" do
      event_type.id.should == event.evid
    end

    it "should take feature from event table" do
      event_type.feature.should == "the_feature"
    end

  end

  describe "update_resource creates new Exectuable" do
    before(:each) {
      Executable.find_by_identifier('the_feature').should be_blank
      event_type.update_resource(resource)
    }

    it "should create an executable" do
      Executable.find_by_identifier('the_feature').should_not be_blank
    end

    it "should set rid of executable" do
      Executable.find_by_identifier('the_feature').rid.should == resource.id
    end

    it "should appear in all EventTypes" do
      EventType.find(event_type.id).resource_name.should == resource.name
    end

  end

  describe "update_resource updates an Executable" do
    let(:resource2) { FactoryGirl.create(:resource, :name => "the_second_resource_name") }
    before(:each) {
      @executable = FactoryGirl.create(:executable, :rid => resource.id, :comment => event.vendor, :identifier => event.feature)
      event_type.update_resource(resource2)
    }

    it "should update rid of executable" do
      Executable.find(@executable.exid).rid.should == resource2.id
    end

  end


end
