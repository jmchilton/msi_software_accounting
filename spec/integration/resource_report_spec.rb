require "spec_helper.rb"


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

