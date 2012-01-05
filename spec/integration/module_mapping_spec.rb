require 'spec_helper.rb'
require 'integration/integration_helpers'

feature "Module Mapping" do
  include IntegrationHelpers

  RESOURCE_NAME = "COLLECTL_TEST_RESOURCE"
  USERNAME = "module_user"

  background do
    FactoryGirl.create(:resource, :name => RESOURCE_NAME)
    user = FactoryGirl.create(:user, :username => USERNAME)
    FactoryGirl.create(:module_load, :username => user.username, :name => "bowtie")
  end

  scenario "unmapped module" do
    build_user_resource_report "Module Load"
    lambda { find_row_with_content(USERNAME) }.should raise_error
  end

  scenario "adding module mapping" do
    map_module
    build_user_resource_report "Module Load"
    find_row_with_content(USERNAME).should_not be_nil
  end

  def map_module
    visit_resource

    click_link "Manage Modules"
    click_link "Map New Module"
    fill_in 'Name', :with => 'bowtie'
    click_button "Create"
  end

end