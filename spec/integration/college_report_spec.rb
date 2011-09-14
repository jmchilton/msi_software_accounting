require 'spec_helper.rb'

feature "College Report" do
  background do
  end

  scenario "default options" do
    visit '/colleges_report/new'
    click_button 'Build Report'
    page.find(:data_table_header).should have_content("College")
    page.should have_content("CFANS")
    #click_button 'Download'
    #page.should have_content('CFANS')
    page.should have_link 'Download CSV'
  end


end
