require 'spec_helper'

describe "executables_plot/new.html.erb" do
  include ViewHelpers

  before(:each) {
    executable = assign(:executable, FactoryGirl.create(:executable))
    path_parameters[:executable_id] = executable.exid
    render
  }

  specify { it_should_render_plot_options }
end
