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

feature "a departments resources report" do
  include IntegrationHelpers

  it_should_behave_like "model with resource reports" do
    let(:model_title) { "Department" }
    let(:model_instance) {
      Department.find_by_name ReportTestData::NON_TECH_DEPARTMENT_NAME
    }
  end

end