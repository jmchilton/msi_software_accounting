require "spec_helper.rb"
require 'integration/integration_helpers'

feature "Download Report" do

  scenario "should generate valid CSV file" do
    visit '/resources_report.csv'
    page.should have_content("resource_1")
  end
end

feature "resources report" do
  include IntegrationHelpers

  background do
    visit_home
  end

  it_should_behave_like "models' report" do
    let(:model_title) { "Resources" }
    let(:expected_columns) { ["Resource"] }
  end


end

