require 'spec_helper'
require 'controllers/table_helpers'

describe CollegesReportController do
  include TableHelpers

  let (:index_params) { {} }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      stub_report_method(College, :report)
    }

    it_should_behave_like "standard report GET index"
  end

end
