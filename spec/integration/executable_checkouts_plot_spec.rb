require 'spec_helper.rb'
require 'report_test_data'

feature "Executable Checkout Plots" do
  include IntegrationHelpers


  background do
    visit_home
    ReportTestData.setup_used_twice_resource(:data_source => :flexlm)
  end

  scenario "build report" do
    visit_flexlm_feature ReportTestData::USED_TWICE_EXECUTABLE_IDENTIFIER
    click_link "Plot Feature Checkouts"
    plot
    page_should_have_chart do |chart_data|
      chart_data[0]["label"].should eql("Checkouts")
      chart_data[0]["data"][0][1].should eql(2)
    end
  end

  scenario "build report excluding employees" do
    visit_flexlm_feature ReportTestData::USED_TWICE_EXECUTABLE_IDENTIFIER
    click_link "Plot Feature Checkouts"
    check "exclude_employees"
    plot
    page_should_have_chart do |chart_data|
      chart_data[0]["label"].should eql("Checkouts")
      chart_data[0]["data"][0][1].should eql(1)
    end
  end


end