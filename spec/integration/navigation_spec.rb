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
    click_link('View Feature Report')
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
