require 'spec_helper'

describe "executables/show.html.erb" do
  include ViewHelpers

  before(:each) do
    @resource = FactoryGirl.create(:resource, :name => "The Resource Name")
    executable = FactoryGirl.build(:executable, :exid => 100, :identifier => "the_feature", :comment => "the_vendor", :resource => @resource)
    @executable = assign(:executable, executable)
    render
  end


  specify { it_should_have_model_field("identifier", "Feature", "the_feature") }
  specify { it_should_have_model_field("comment", "Vendor", "the_vendor") }

  specify { it_should_have_model_link 'Edit',  edit_executable_path(@executable) }
  specify { it_should_have_model_link 'Back to Resource The Resource Name',  resource_path(@resource) }
  specify { it_should_have_model_link 'Back to FLEXlm Feature Index',  executables_path }

end
