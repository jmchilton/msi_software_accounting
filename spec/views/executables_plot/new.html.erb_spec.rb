require 'spec_helper'

describe "executables_plot/new.html.erb" do
  include ViewHelpers

  before(:each) {
    executable = assign(:executable, FactoryGirl.create(:executable))
    params[:executable_id] = executable.exid
    render
  }

  specify { it_should_render_report_options }
end
