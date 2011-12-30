require 'spec_helper'

describe "resource_model_report/new.html.erb" do
  include ViewHelpers

  before(:each) {
    params[:model_type] = "user"
    render_mock :resource
  }

  specify { it_should_render_report_options }
end
