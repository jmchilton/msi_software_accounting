require 'spec_helper'

describe "resource_user_report/new.html.erb" do
  include ViewHelpers

  before(:each) {
    render_mock :resource
  }

  specify { it_should_render_report_options }
end
