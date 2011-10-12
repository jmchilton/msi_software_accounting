require 'spec_helper'

describe "executables/show.html.erb" do
  include ViewHelpers

  before(:each) do
    @resource = FactoryGirl.create(:resource, :name => "The Resource Name")
    executable = FactoryGirl.build(:executable, :exid => 100, :identifier => "the_feature", :comment => "the_vendor", :resource => @resource)
    @executable = assign(:executable, executable)
    render
  end

  specify { it_should_have_title_text("FLEXlm Feature the_feature") }
  specify { it_should_have_model_field("resource", "Resource", "The Resource Name") }
  specify { it_should_have_model_field("identifier", "Feature", "the_feature") }
  specify { it_should_have_model_field("comment", "Vendor", "the_vendor") }

  specify { it_should_have_model_link 'Build Per User FLEXlm Usage Report',  new_executable_executable_user_report_path(@executable) }
  specify { it_should_have_model_link 'Plot Feature Usage',  new_executable_executables_plot_path(@executable) }
  specify { it_should_have_model_link 'Back to Resource The Resource Name',  resource_path(@resource) }
  specify { it_should_have_model_link 'Back to FLEXlm Feature Index',  executables_path }

end
