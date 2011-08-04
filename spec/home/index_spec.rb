require 'spec/spec_helper'

feature "Index Page", %q{
  In order to navigate the reports
  I want to see a link for reports
} do
  background do
  end

  scenario "Navigate to software report" do
    visit '/'
    click_link('Software Report')
    current_path.should == resources_report_path
  end

  scenario "Navigate to college report" do
    visit '/'
    click_link('College Report')
    current_path.should == colleges_report_path
  end

  scenario "Report" do
    visit '/resources/show_report'
    page.should have_content('10')
  end

end
