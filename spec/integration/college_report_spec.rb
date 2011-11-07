require 'spec_helper.rb'
require 'integration/integration_helpers'

feature "College Report" do
  include IntegrationHelpers

  background do
  end

  scenario "default options" do
    visit '/colleges_report/new'
    build_report
    page.find(:data_table_header).should have_content("College")
    page.should have_content("CFANS")
    page.should have_link 'Download CSV'
  end

end
