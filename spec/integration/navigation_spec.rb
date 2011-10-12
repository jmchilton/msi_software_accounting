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

  def can_visit_models_report(link_name, model_name)
    visit '/'
    within('#links-flexlm-reports') do
      click_link(link_name)
    end
    current_path.should eql(eval("new_#{model_name}s_report_path"))
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
    visit '/'
    within("#links-navigate") do
      click_link('Resources')
    end
    current_path.should eql(resources_path)
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('Build Per User FLEXlm Usage Report')
    click_button("Build Report")
    page.should have_content("alice") # Alice uses resource 1
  end

  scenario "Navigate to FLEXlm Features" do
    visit '/'
    within("#links-navigate") do
      click_link('FLEXlm Features')
    end
    current_path.should eql(executables_path)
  end

  specify "Navigate to add purchase" do
    visit '/'
    within('#links-manage') do
      click_link('Purchases')
    end
    current_path.should eql(purchases_path)
    click_link('New Purchase')
    current_path.should eql(new_purchase_path)
  end

  specify "Navigate to feature report" do
    visit '/'
    within("#links-navigate") do
      click_link('Resources')
    end
    current_path.should eql(resources_path)
    click_link('View')
    current_path.should eql(resource_path(1))
    click_link('Build FLEXlm Feature Report')
    current_path.should eql(new_resource_executables_report_path(1))
    click_button("Build Report")
    current_path.should eql(resource_executables_report_index_path(1))
  end

  specify "Navigate to edit flexlm mapping" do
    visit '/'
    within('#links-manage') do
      click_link('FLEXlm Mapping')
    end
    current_path.should eql(event_types_path)
  end

  specify "previous report data range should be default for new reports" do
    visit new_resources_report_path
    fill_in('From', :with => '12-05-2011')
    fill_in('To', :with => '12-05-2012')
    click_button("Build Report")
    visit new_colleges_report_path
    find_field('From').value.should == '12-05-2011'
    find_field('To').value.should == '12-05-2012'
  end


end
