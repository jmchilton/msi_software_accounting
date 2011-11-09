require 'spec_helper'
require 'integration/integration_helpers'

feature "Index Page", %q{
  In order to navigate the site
  As any user
  I want to see links for relevant sections
} do
  include IntegrationHelpers

  background do
  end

  scenario "Navigate to software report" do
    visit_home
    within("#links-flexlm-reports") do
      click_link('Resources')
    end
    current_path.should eql(new_resources_report_path)
  end

  def can_visit_models_report(link_name, model_name)
    report_types = [:flexlm, :collectl]
    report_types.each do |report_type|
      visit_home
      click_report_link report_type, link_name
      current_path.should eql(eval("new_#{model_name}s_report_path"))
      build_and_verify_report
    end
  end

  scenario "Navigate to college report" do
    can_visit_models_report "Colleges", "college"
  end

  scenario "Navigate to departments report" do
    can_visit_models_report "Departments", "department"
  end

  scenario "Navigate to groups report" do
    can_visit_models_report "Groups", "group"
  end

  scenario "Navigate to resources" do
    visit_navigate_resources
    current_path.should eql(resources_path)
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('Build Per User FLEXlm Usage Report')
    build_report
    page.should have_content("alice") # Alice uses resource 1
  end

  scenario "Navigate to FLEXlm Features" do
    visit_home
    within("#links-navigate") do
      click_link('FLEXlm Features')
    end
    current_path.should eql(executables_path)
  end

  specify "Navigate to add purchase" do
    visit_home
    within('#links-manage') do
      click_link('Purchases')
    end
    current_path.should eql(purchases_path)
    click_link('New Purchase')
    current_path.should eql(new_purchase_path)
  end

  specify "Navigate to feature report" do
    visit_navigate_resources
    current_path.should eql(resources_path)
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('Build FLEXlm Feature Report')
    current_path.should eql(new_resource_executables_report_path(1))
    build_report
    current_path.should eql(resource_executables_report_index_path(1))
  end

  specify "Navigate to edit flexlm mapping" do
    visit_home
    within('#links-manage') do
      click_link('FLEXlm Mapping')
    end
    current_path.should eql(event_types_path)
  end

  specify "previous report data range should be default for new reports" do
    visit new_resources_report_path
    fill_in('From', :with => '12-05-2011')
    fill_in('To', :with => '12-05-2012')
    build_report
    visit new_colleges_report_path
    find_field('From').value.should == '12-05-2011'
    find_field('To').value.should == '12-05-2012'
  end


end
