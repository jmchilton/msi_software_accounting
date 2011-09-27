require 'spec_helper'

describe FlexlmAppSnapshot do

  describe "summarize" do
    before(:each) {
      @executable = FactoryGirl.create(:executable)
      @snapshot2 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 1, :for_date => '2011-09-01 01:00:00', :executable => @executable)
      @snapshot1 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 1, :for_date => '2011-09-01 02:00:00', :executable => @executable)
      @snapshot3 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 5, :for_date => '2011-09-01 03:00:00', :executable => @executable)
      @snapshot4 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 5, :for_date => '2011-09-01 04:00:00', :executable => @executable)
      @out_snapshot1 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 4, :for_date => '2011-08-29 21:00:00', :executable => @executable)
    }

    it "should sample daily average when specified" do
      sept_first_record = FlexlmAppSnapshot.summarize_for_executable(@executable.exid, {:sample => :date, :from => '2011-09-01', :to => '2011-09-30'})[0]
      sept_first_record.sum_avg.should == 3
      sept_first_record.for_date.should == Time.zone.parse('2011-09-01')
      FlexlmAppSnapshot.summarize_for_executable(@executable.exid, {:from => '2011-08-01', :to => '2011-08-31'})[0].sum_avg.should == 4
    end

    it "should sample continuously by default" do
      records = FlexlmAppSnapshot.summarize_for_executable(@executable.exid, {:from => '2011-09-01', :to => '2011-09-30'})
      snapshot2_record = records.select {|x| x.for_date == Time.zone.parse('2011-09-01 01:00:00 ')}[0]
      snapshot3_record = records.select {|x| x.for_date == Time.zone.parse('2011-09-01 03:00:00 ')}[0]
      snapshot2_record.sum_avg.should == 1
      snapshot3_record.sum_avg.should == 5
    end
  end


end
