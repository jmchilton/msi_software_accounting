require 'spec_helper'

describe FlexlmAppSnapshot do

  describe "summarize" do
    before(:each) {
      @executable = FactoryGirl.create(:executable)
      @snapshot1 = FactoryGirl.create(:flexlm_app_snapshot, :used_licenses => 3, :executable => @executable)
    }

    it "should average" do

      FlexlmAppSnapshot.summarize_for_executable(@executable.exid).sum_avg.should == 3
    end
  end


end
