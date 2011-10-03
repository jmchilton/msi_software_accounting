require 'spec_helper'

describe "resource_user_report/new.html.erb" do
  include ViewHelpers

  before(:each) {
    resource = assign(:resource, FactoryGirl.create(:resource))
    params[:resource_id] = resource.id
    render
  }

  specify { it_should_render_report_options }
end
