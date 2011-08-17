require 'spec_helper'

describe "executables/edit.html.erb" do
  before(:each) do
    @executable = assign(:executable, stub_model(Executable))
  end

  it "renders the edit executable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => executables_path(@executable), :method => "post" do
    end
  end
end
