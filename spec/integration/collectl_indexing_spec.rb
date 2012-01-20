require 'spec_helper.rb'
#require 'integration/integration_helpers'

feature "Collectl Indexing" do
  include IntegrationHelpers

  RESOURCE_NAME = "COLLECTL_TEST_RESOURCE"
  EXECUTABLE_NAME = 'resource.exe'
  USERNAME = "collectl_user"

  background do
    FactoryGirl.create(:resource, :name => RESOURCE_NAME)
    user = FactoryGirl.create(:user, :username => USERNAME)
    FactoryGirl.create(:raw_collectl_execution, :uid => user.uid, :executable => "/usr/bin/resource.exe")
  end

  scenario "unindexed collectl executions" do
    verify_user_not_found_in_resource_report
  end

  scenario "adding collectl executable" do
    add_collectl_executable
    build_collectl_user_resource_report
    find_row_with_content(USERNAME).should_not be_nil
  end

  scenario "deleting collectl executable" do
    add_collectl_executable
    manage_executables
    view_row_with_content EXECUTABLE_NAME
    click_link 'Delete Executable'
    verify_user_not_found_in_resource_report
  end

  def add_collectl_executable
    manage_executables
    click_link "New Executable"
    fill_in 'Name', :with => EXECUTABLE_NAME
    click_button "Create"
  end

  def manage_executables
    visit_resource
    click_link "Manage Collectl Executables"
  end

  def verify_user_not_found_in_resource_report
    build_collectl_user_resource_report
    lambda { find_row_with_content USERNAME }.should raise_error
  end

  def build_collectl_user_resource_report
    build_user_resource_report "Collectl"
  end

end