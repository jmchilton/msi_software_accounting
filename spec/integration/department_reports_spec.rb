require 'spec_helper.rb'
require 'integration/integration_helpers'

feature "Department Reports" do
  include IntegrationHelpers

  background do
    visit_home
  end

  it_should_behave_like "models' report" do
    let(:model_title) { "Departments" }
    let(:expected_columns) { ["Department"] }
  end


end
