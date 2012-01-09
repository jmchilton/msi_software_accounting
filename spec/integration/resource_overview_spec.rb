require 'spec_helper.rb'

feature "resource data summaries" do
  include IntegrationHelpers
  include HasSummary

  RESOURCE_NAME = "bowtie"

  background do
    @resource = FactoryGirl.create(:resource, :name => RESOURCE_NAME)

  end

  scenario "module overview" do
    software_module = FactoryGirl.create(:module, :resource => @resource)
    setup_module_loads software_module
    visit_resource
    click_link "Module Load Data Summary"
    it_should_have_model_field("count", "Number of Module Loads", "3")
  end

end