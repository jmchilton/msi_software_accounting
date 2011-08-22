require "spec_helper.rb"

feature "Download Report" do

  scenario "should generate valid CSV file" do
    visit '/resources_report.csv'
    page.should have_content("resource_1")
  end

end

