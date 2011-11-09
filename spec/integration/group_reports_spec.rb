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
