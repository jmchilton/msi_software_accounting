require 'spec_helper'
require 'controllers/table_helpers'

describe ExecutableUserReportController do
  include TableHelpers

  before(:each) {
    setup_parent_executable
  }

  it_should_behave_like "standard report GET new"

  describe "report GET index" do
    before(:each) {
      User.stub(:executable_report).with(executable.id, expected_report_options).and_return(row_relation)
    }

    it_should_behave_like "standard report GET index"
  end

end
