require 'spec_helper'

describe FlexlmAppSnapshot do

  describe "sampling" do
    before(:each) {
      @executable = FactoryGirl.create(:executable)
      @snapshot2 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 1, :for_date => '2011-09-01 01:00:00', :executable => @executable)
      @snapshot1 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 1, :for_date => '2011-09-01 02:00:00', :executable => @executable)
      @snapshot3 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 5, :for_date => '2011-09-01 03:00:00', :executable => @executable)
      @snapshot4 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 5, :for_date => '2011-09-01 04:00:00', :executable => @executable)
      @out_snapshot1 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 4, :for_date => '2011-08-29 21:00:00', :executable => @executable)
    }

    describe "daily sampling" do
      let(:sept_first_record) { FlexlmAppSnapshot.sample_for_executable(@executable.exid, {:sample => "date", :from => '2011-09-01', :to => '2011-09-30'})[0] }

      it  "should average records by default" do
        sept_first_record.value.should == 3
      end

      it "should truncate the date"  do
         sept_first_record.for_date.should == Time.zone.parse('2011-09-01')
      end

    end

    describe "daily sampling with maximum" do
      let(:sept_first_record) { FlexlmAppSnapshot.sample_for_executable(@executable.exid, {:sample_with => "max", :sample => "date", :from => '2011-09-01', :to => '2011-09-30'})[0] }

      it "should take the maximum number of licenses for that day" do
        sept_first_record.value.should == 5
      end
    end

    describe "sampling date ranges" do
      specify { FlexlmAppSnapshot.sample_for_executable(@executable.exid, {:from => '2011-08-01', :to => '2011-08-31'})[0].value.should == 4 }
    end

    describe "continuous sampling" do
      let(:sept_records) { FlexlmAppSnapshot.sample_for_executable(@executable.exid, {:from => '2011-09-01', :to => '2011-09-30'}) }
      let(:snapshot2_record) { sept_records.select {|x| x.for_date == Time.zone.parse('2011-09-01 01:00:00 ')}[0] }
      let(:snapshot3_record) { sept_records.select {|x| x.for_date == Time.zone.parse('2011-09-01 03:00:00 ')}[0] }

      specify { snapshot2_record.value.should == 1 }
      specify { snapshot3_record.value.should == 5 }
    end

  end
end
