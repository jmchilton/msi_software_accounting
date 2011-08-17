require 'spec_helper'

describe "executables/new.html.erb" do
  before(:each) do
    assign(:executable, stub_model(Executable).as_new_record)
  end

  it "renders new executable form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => executables_path, :method => "post" do
    end
  end
end
