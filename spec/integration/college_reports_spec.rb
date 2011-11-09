require 'spec_helper.rb'
require 'integration/integration_helpers'
require 'report_test_data'

feature "College Reports" do
  include IntegrationHelpers

  background do
    visit_home
  end

  it_should_behave_like "models' report" do
    let(:model_title) { "Colleges" }
    let(:expected_columns) { ["College"] }
  end

  scenario "default options" do
    click_report_link :flexlm, "Colleges"
    page_should_have_header "FLEXlm Colleges Report"
    build_and_verify_report
    table_should_have_column "College"
    page.should have_content "CFANS"
  end

  it_should_behave_like "model instance's resource report" do
    let(:model_title) { "College" }
    let(:model_instance) {
      ReportTestData.setup_used_twice_resource(:data_source => data_source)
      College.find_by_name ReportTestData::TECH_COLLEGE_NAME
    }
  end

end
