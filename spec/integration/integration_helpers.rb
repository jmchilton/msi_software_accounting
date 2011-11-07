module IntegrationHelpers

  def it_should_have_msi_db_link_for(object)
    page.find_link("msi_db_link")[:href].should == object.msi_db_link
  end

  def visit_home
    visit '/'
  end

  def visit_navigate_resources
    visit_home
    within("#links-navigate") do
      click_link('Resources')
    end
  end

  def find_row_with_content(cell_contents)
    find(:xpath, "//table[@id='data_table']/tr/td[.='#{cell_contents}']/..")
  end

  def view_row_with_content(cell_contents)
    find_row_with_content(cell_contents).click_link 'View'
  end

  def build_report
    click_button 'Build Report'
  end

end