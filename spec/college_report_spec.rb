require 'spec_helper.rb'

feature "College Report" do
  background do
  end

  scenario "Default options" do
    visit '/colleges/report'
    click_button 'Show Report'
    #click_button 'Download'
    #page.should have_content('CFANS')
  end
end
