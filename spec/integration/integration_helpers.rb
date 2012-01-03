module IntegrationHelpers


  def it_should_download_file_named filename
    page.response_headers['Content-Disposition'].should include("filename=\"#{filename}\"")
  end

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
      build_and_verfiy_report_and_columns
    end

    scenario "collectl report with default options" do
      click_report_link :collectl, model_title
      page_should_have_header "Collectl #{model_title} Report"
      build_and_verfiy_report_and_columns
    end

    scenario "module report with default options" do
      click_report_link :module, model_title
      page_should_have_header "Module Load #{model_title} Report"
      build_and_verfiy_report_and_columns
    end

    def build_and_verfiy_report_and_columns
      build_and_verify_report
      expected_columns.each do |expected_column|
        table_should_have_column expected_column
      end
    end

  end



  shared_examples_for "model instance's data_source report with default options" do
    scenario "default options" do
      navigate model_title
      view_row_with_content model_instance.name
      click_link "Build #{data_source_title} Resource Usage Report"
      report_title = "#{data_source_title} Resources Report for #{model_title} #{model_instance.name}"
      page_should_have_header report_title
      build_and_verify_report
      table_should_have_column data_source_column
      page_should_have_header report_title
      view_row_with_content ReportTestData::USED_TWICE_RESOURCE_NAME
    end
  end

  def data_source_column
    {:collectl => "Executions", :flexlm => "Checkouts", :module => "Loads"}[data_source]
  end

  #deprecated
  shared_examples_for "model instance's resource report" do

    before(:each) do
      visit_home
      ReportTestData.setup_used_twice_resource(:data_source => data_source)
    end


    it_should_behave_like "model instance's data_source report with default options" do
      let(:data_source) { :flexlm }
      let(:data_source_title) { "FLEXlm" }
    end

    it_should_behave_like "model instance's data_source report with default options" do
      let(:data_source) { :collectl }
      let(:data_source_title) { "Collectl" }
    end


  end

  shared_examples_for "model's data_source report with default options" do
    scenario "default options" do
      visit_navigate_resources
      resource_name = ReportTestData::USED_TWICE_RESOURCE_NAME
      view_row_with_content resource_name
      click_link "Build Per #{model_title} #{data_source_title} Usage Report"
      report_title = "#{data_source_title} #{model_title} Report for #{resource_name}"
      page_should_have_header report_title
      build_and_verify_report
      page_should_have_header report_title
      table_should_have_column data_source_column
      view_row_with_content model_instance.name
    end
  end

  shared_examples_for "model's data_source executable report with default options" do
    let(:data_source_title) { "FLEXlm" }
    let(:data_source) { :flexlm }

    before(:each) do
      visit_home
      ReportTestData.setup_used_twice_resource(:data_source => data_source)
    end

    scenario "default options" do
      navigate "FLEXlm Features"
      executable_name = ReportTestData::USED_TWICE_EXECUTABLE_IDENTIFIER
      view_row_with_content executable_name
      click_link "Build Per #{model_title} #{data_source_title} Usage Report"
      report_title = "#{data_source_title} #{model_title} Report for Feature #{executable_name}"
      page_should_have_header report_title
      build_and_verify_report
      page_should_have_header report_title
      table_should_have_column data_source_column
      view_row_with_content model_instance.name
    end
  end

  shared_examples_for "model's data_source batch resource report" do
    scenario "default options" do
      navigate model_title
      click_link "Build #{data_source_title} #{model_title} Reports for Multiple Resources"
      report_title = "#{data_source_title} #{model_title} Reports for Multiple Resources"
      page_should_have_header report_title
      build_report
      it_should_download_file_named "#{model_title.downcase}_reports.zip"
    end
  end

  shared_examples_for "model's data_source report with default options for each data source" do
    it_should_behave_like "model's data_source report with default options" do
      let(:data_source) { :flexlm }
      let(:data_source_title) { "FLEXlm" }
    end

    it_should_behave_like "model's data_source report with default options" do
      let(:data_source) { :collectl }
      let(:data_source_title) { "Collectl" }
    end

    it_should_behave_like "model's data_source report with default options" do
      let(:data_source) { :module }
      let(:data_source_title) { "Module Load" }
    end

  end

  shared_examples_for "model instance's data_source report with default options for each data source" do
    it_should_behave_like "model instance's data_source report with default options" do
      let(:data_source) { :flexlm }
      let(:data_source_title) { "FLEXlm" }
    end

    it_should_behave_like "model instance's data_source report with default options" do
      let(:data_source) { :collectl }
      let(:data_source_title) { "Collectl" }
    end

    it_should_behave_like "model instance's data_source report with default options" do
      let(:data_source) { :module }
      let(:data_source_title) { "Module Load" }
    end

  end

  shared_examples_for "model's data_source batch resource report for each data source"  do
    it_should_behave_like "model's data_source batch resource report" do
      let(:data_source) { :flexlm }
      let(:data_source_title) { "FLEXlm" }
    end

    it_should_behave_like "model's data_source batch resource report" do
      let(:data_source) { :collectl }
      let(:data_source_title) { "Collectl" }
    end

    it_should_behave_like "model's data_source batch resource report" do
      let(:data_source) { :module }
      let(:data_source_title) { "Module Load" }
    end

  end



  shared_examples_for "model with resource reports" do
    before(:each) do
      visit_home
      ReportTestData.setup_used_twice_resource(:data_source => data_source)
    end

    it_should_behave_like "model's data_source report with default options for each data source"
    it_should_behave_like "model instance's data_source report with default options for each data source"
    it_should_behave_like "model's data_source batch resource report for each data source"
    it_should_behave_like "model's data_source executable report with default options"
  end




end