require 'spec_helper'

feature "Index Page", %q{
  In order to navigate the site
  As any user
  I want to see links for relevant sections
} do
  background do
  end

  scenario "Navigate to software report" do
    visit '/'
    within("#links-flexlm-reports") do
      click_link('Resources')
    end
    current_path.should eql(new_resources_report_path)
  end

  scenario "Navigate to college report" do
    visit '/'
    within("#links-flexlm-reports") do
      click_link('Colleges')
    end
    current_path.should eql(new_colleges_report_path)
  end

  scenario "Navigate to resources" do
    visit '/'
    within("#links-navigate") do
      click_link('Resources')
    end
    current_path.should eql(resources_path)
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('View Per User Usage Report')
    click_button("Build Report")
    page.should have_content("alice") # Alice uses resource 1
  end

end
