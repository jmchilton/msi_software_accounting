require 'spec_helper.rb'
#require 'integration/integration_helpers'


feature "a users resources report" do
  include IntegrationHelpers

  it_should_behave_like "model with resource reports" do
    let(:model_title) { "User" }
    let(:model_instance) {
      User.find_by_username ReportTestData::NON_TECH_USERNAME
    }
  end

end