require 'spec_helper'

describe "user_resources_report/new.html.erb" do
  include ViewHelpers

  def _controller_path
    "model_resources_report"
  end

  before(:each) {
    path_parameters[:model_type] = "user"
    render_mock :user
  }

  specify { it_should_render_report_options(:exclude_employees => false) }
end
