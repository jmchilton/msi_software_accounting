require 'spec_helper.rb'

feature "resource data summaries" do
  include IntegrationHelpers
  include HasSummary

  RESOURCE_NAME = "bowtie"

  scenario "module overview" do
    resource = FactoryGirl.create :resource, :name => RESOURCE_NAME
    software_module = FactoryGirl.create :module, :resource => resource, :name => "test_module"
    setup_module_loads software_module
    visit_resource
    click_link "Module Load Data Summary"
    it_should_have_model_field "count", "Number of Module Loads", "3"
  end

end