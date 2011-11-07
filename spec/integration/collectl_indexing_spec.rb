require 'spec_helper.rb'
require 'integration/integration_helpers'

feature "Collectl Indexing" do
  include IntegrationHelpers

  RESOURCE_NAME = "COLLECTL_TEST_RESOURCE"
  USERNAME = "collectl_user"

  background do
    FactoryGirl.create(:resource, :name => RESOURCE_NAME)
    user = FactoryGirl.create(:user, :username => USERNAME)
    FactoryGirl.create(:raw_collectl_execution, :uid => user.uid, :executable => "/usr/bin/resource.exe")
  end

  scenario "unindexed collectl executions" do
    build_user_resource_report
    lambda { find_row_with_content("collectl_user") }.should raise_error
  end


  scenario "adding collectl executable" do
    add_collectl_executable
    build_user_resource_report
    find_row_with_content("collectl_user").should_not be_nil
  end

  def add_collectl_executable
    visit_test_resource

    click_link "Manage Collectl Executables"
    click_link "New Executable"
    fill_in 'Name', :with => 'resource.exe'
    click_button "Create Collectl executable"
  end

  def build_user_resource_report
    visit_test_resource
    click_link "Build Per User Collectl Usage Report"
    build_report
  end

  def visit_test_resource
    visit_navigate_resources
    view_row_with_content "COLLECTL_TEST_RESOURCE"
  end


end