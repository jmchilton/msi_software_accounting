require 'spec_helper'

describe "executables_plot/index.html.erb" do
  include ViewHelpers

  before(:each) {
    executable = assign(:executable, FactoryGirl.create(:executable))
    params[:executable_id] = executable.exid
    setup_test_chart_data
    render
  }

  specify { it_should_render_a_chart }

end
