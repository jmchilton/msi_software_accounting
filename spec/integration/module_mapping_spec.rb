require 'spec_helper.rb'
#require 'integration/integration_helpers'

feature "Module Mapping" do
  include IntegrationHelpers

  RESOURCE_NAME = "COLLECTL_TEST_RESOURCE"
  MODULE_NAME = 'bowtie'
  USERNAME = "module_user"

  background do
    FactoryGirl.create(:resource, :name => RESOURCE_NAME)
    user = FactoryGirl.create(:user, :username => USERNAME)
    FactoryGirl.create(:module_load, :username => user.username, :name => "bowtie")
  end

  scenario "unmapped module" do
    verify_user_not_found_in_resource_report
  end

  scenario "adding module mapping" do
    map_module
    build_user_resource_report "Module Load"
    find_row_with_content(USERNAME).should_not be_nil
  end

  scenario "delete module mapping" do
    map_module
    manage_resource_modules
    view_row_with_content MODULE_NAME
    click_link 'Delete Module'
    verify_user_not_found_in_resource_report
  end

  def verify_user_not_found_in_resource_report
    build_user_resource_report "Module Load"
    lambda { find_row_with_content(USERNAME) }.should raise_error
  end

  def manage_resource_modules
    visit_resource
    click_link "Manage Modules"

  end

  def map_module
    manage_resource_modules
    click_link "Map New Module"
    fill_in 'Name', :with => MODULE_NAME
    click_button "Create"
  end

end