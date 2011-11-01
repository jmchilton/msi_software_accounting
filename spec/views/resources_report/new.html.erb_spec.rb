require 'spec_helper'

describe "resources_report/new.html.erb" do
  include ViewHelpers

  before(:each) {
    render_mock :user
  }

  specify { it_should_render_report_options(:limit_users => true) }
end
