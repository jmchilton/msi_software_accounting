require 'spec_helper.rb'
#require 'integration/integration_helpers'

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

#feature "batch resource group report" do
#  include IntegrationHelpers
#
#  background do
#    visit_home
#  end
#
#  let(:data_source) { :flexlm }
#  let(:data_source_title) { "FLEXlm" }
#  let(:model_title) { "Group" }
#
#  it "should have batch resource report" do
#    navigate model_title
#    click_link "Build #{data_source_title} #{model_title} Reports for Multiple Resources"
#    report_title = "#{data_source_title} #{model_title} Reports for Multiple Resources"
#    page_should_have_header report_title
#    build_report
#    it_should_download_file_named "group_reports.zip"
#  end
#
#end