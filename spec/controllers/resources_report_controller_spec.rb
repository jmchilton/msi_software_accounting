require 'spec_helper'
require 'controllers/table_helpers'

describe ResourcesReportController do
  include TableHelpers

  let (:index_params) { {} }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      Resource.stub(:report).with(expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

  describe "GET index" do
    before(:each) { get 'index' }

    specify { it_should_respond_successfully_with_report }
    specify { it_should_assign_links_with "resource_path" }
  end



end
