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
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('View Usage Report')
    click_button("Show Usage Report")
    page.should have_content("alice") # Alice uses resource 1
  end

end
