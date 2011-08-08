require 'spec_helper'

describe College do

  it "Reports should contain CFANS" do
    College.report.first.name.should eql("CFANS")
  end
  
  it "Should be readonly" do 
    college = FactoryGirl.create(:college)
    lambda {college.destroy}.should raise_error(ActiveRecord::ReadOnlyRecord)
  end  
  
end

