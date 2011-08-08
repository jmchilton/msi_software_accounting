require 'spec_helper'

feature "College report" do

  scenario "Default options" do
    College.report.first.name.should == "CFANS"

  end
  
end

