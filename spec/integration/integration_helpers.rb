module IntegrationHelpers

  def it_should_have_msi_db_link_for(object)
    page.find_link("msi_db_link")[:href].should == object.msi_db_link
  end

  def visit_home
    visit '/'
  end

  def navigate(link_name)
    visit_home
    within("#links-navigate") do
      click_link(link_name)
    end

  end

  def visit_navigate_resources
    navigate "Resources"
  end

  def click_report_link(data_source, link_name)
    within("#links-#{data_source}-reports") do
      click_link(link_name)
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

  def page_should_have_header(header)
    page.find(:xpath, "//h1").should have_content(header)
  end

  def page_should_have_path(path)
    find(:xpath, path).should_not be_nil
  end

  def page_should_contain_report
    page.find(:data_table_header).should_not be_nil
    page.should have_link 'Download CSV'
  end

  def build_and_verify_report
    build_report
    page_should_contain_report
  end

  def table_should_have_column(column_title)
    page_should_have_path "//tr[@id='data_table_header']/td[.='#{column_title}']"
  end

  shared_examples_for "models' report" do
    scenario "flexlm report with defualt options" do
      click_report_link :flexlm, model_title
      page_should_have_header "FLEXlm #{model_title} Report"
      build_and_verify_report
      expected_columns.each do |expected_column|
        table_should_have_column expected_column
      end
    end

    scenario "collectl report with defualt options" do
      click_report_link :collectl, model_title
      page_should_have_header "Collectl #{model_title} Report"
      build_and_verify_report
      expected_columns.each do |expected_column|
        table_should_have_column expected_column
      end
    end

  end

  shared_examples_for "model instance's resource report" do
    shared_examples_for "data_source report with default options" do
      scenario "default options" do
        #pending "fix this"
      navigate model_title
      pending "fix this"
      view_row_with_content model_instance.name
      click_link "Build #{data_source_title} Resource Usage Report"
      report_title = "#{data_source_title} Resources Report for #{model_title} #{model_instance.name}"
      page_should_have_header report_title
      build_and_verify_report
      page_should_have_header report_title
      end
      end

    it_should_behave_like "data_source report with default options" do
      let(:data_source) { :flexlm }
      let(:data_source_title) { "FLEXlm" }
    end

    it_should_behave_like "data_source report with default options" do
      let(:data_source) { :collectl }
      let(:data_source_title) { "Collectl" }

    end


  end



end