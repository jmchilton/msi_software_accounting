require 'spec_helper'

describe "executables/show.html.erb" do
  include ViewHelpers

  before(:each) do
    executable = FactoryGirl.build(:executable, :exid => 100, :identifier => "the_feature", :comment => "the_vendor")
    @executable = assign(:executable, executable)
    render
  end

  specify { it_should_have_model_field("identifier", "Feature", "the_feature") }
  specify { it_should_have_model_field("comment", "Vendor", "the_vendor") }

end
