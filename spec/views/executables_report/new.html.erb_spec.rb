require 'spec_helper'

describe "executables_report/new.html.erb" do
  include ViewHelpers

  before(:each) {
    @resource = FactoryGirl.create(:resource)
    path_parameters[:resource_id] = @resource.id
    render_mock :user
  }

  specify { it_should_render_report_options(:limit_users => true) }
end
