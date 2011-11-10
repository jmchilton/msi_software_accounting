require 'spec_helper.rb'
require 'integration/integration_helpers'

feature "Group Reports" do
  include IntegrationHelpers

  background do
    visit_home
  end

  it_should_behave_like "models' report" do
    let(:model_title) { "Groups" }
    let(:expected_columns) { ["Group"] }
  end

end


feature "a groups resources report" do
  include IntegrationHelpers

  it_should_behave_like "model with resource reports" do
    let(:model_title) { "Group" }
    let(:model_instance) {
      Group.find_by_name ReportTestData::NON_TECH_GROUP_NAME
    }
  end

end