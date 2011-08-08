require 'spec/spec_helper'

feature "Index Page", %q{
  In order to navigate the site
  As any user
  I want to see links for relevant sections
} do
  background do
  end

  scenario "Navigate to software report" do
    visit '/'
    click_link('Software Report')
    current_path.should eql(resources_report_path)
  end

  scenario "Navigate to college report" do
    visit '/'
    click_link('College Report')
    current_path.should eql(colleges_report_path)
  end

  scenario "Navigate to resources" do
    visit '/'
    click_link('View Resources')
    current_path.should eql(resources_path)
  end 

end
