require 'spec_helper'

describe EventType do

  describe "all" do
    it "should contain vendor from event table" do 
      EventType.all[0].vendor.should == "Vendor2" 
    end 

    it "should take smallest id from event table" do
      EventType.all[0].id == 1
    end

    it "should take feature from event table" do
      EventType.all[0].feature == 2
    end 

  end

  describe "update_resource" do
    it "should create an executable" do 
      Executable.find_by_identifier('unmapped_feature').should be_blank
      event_type = EventType.all.find {|x| x.id == 6 } 
      event_type.update_resource("2")
      Executable.find_by_identifier('unmapped_feature').should_not be_blank
    end
  end

end
