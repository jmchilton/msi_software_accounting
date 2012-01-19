require 'spec_helper.rb'
require 'report_test_data'

feature "Executable Checkout Plots" do
  include IntegrationHelpers


  background do
    visit_home
    ReportTestData.setup_used_twice_resource(:data_source => :flexlm)
  end

  scenario "build plot with default options" do
    plot_feature_checkouts
    page_should_have_n_checkouts 2
  end

  scenario "build plot excluding employees" do
    plot_feature_checkouts do
      check "exclude_employees"
    end
    page_should_have_n_checkouts 1
  end

  scenario "build plot with capturing date range" do
    plot_feature_checkouts do
      fill_in 'from', :with => (ReportTestData::USED_TWICE_DATE - 2.day).strftime('%Y-%m-%d')
      fill_in 'to', :with => (ReportTestData::USED_TWICE_DATE + 2.day).strftime('%Y-%m-%d')
    end
    page_should_have_n_checkouts 2
  end

  scenario "build plot with empty date range" do
    plot_feature_checkouts do
      fill_in 'from', :with => (ReportTestData::USED_TWICE_DATE - 5.days).strftime('%Y-%m-%d')
      fill_in 'to', :with => (ReportTestData::USED_TWICE_DATE - 4.days).strftime('%Y-%m-%d')
    end
    page_should_have_no_checkouts
  end

  scenario "build plot limiting users" do
    plot_feature_checkouts do
      fill_in 'limit_users', :with => ReportTestData::TECH_USERNAME
    end
    page_should_have_n_checkouts 1
  end

  def plot_feature_checkouts
    visit_flexlm_feature ReportTestData::USED_TWICE_EXECUTABLE_IDENTIFIER
    click_link "Plot Feature Checkouts"
    if block_given?
      yield
    end
    plot
  end

  def page_should_have_no_checkouts
    page_should_have_chart do |chart_data|
      chart_data[0]["label"].should eql("Checkouts")
      chart_data[0]["data"].length.should eql(0)
    end
  end

  def page_should_have_n_checkouts(n)
    page_should_have_chart do |chart_data|
      chart_data[0]["label"].should eql("Checkouts")
      chart_data[0]["data"][0][1].should eql(n)
    end
  end


end