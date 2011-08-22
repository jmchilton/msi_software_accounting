require 'spec_helper'
require 'controllers/table_helpers'

describe CollegesReportController do
  include TableHelpers

  let (:index_params) { {} }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      College.stub(:report).with(expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

  describe "GET new" do
    before(:each) { get :new }
    specify { response.should be_success }
    specify { response.should render_template("report")}
  end


  describe "GET index" do

    before(:each) { get :index }

    specify { it_should_respond_successfully_with_template }
    specify { it_should_setup_table_variables }
  end

end
