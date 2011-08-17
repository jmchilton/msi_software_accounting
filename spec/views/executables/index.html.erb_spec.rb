require 'spec_helper'

describe "executables/index.html.erb" do
  before(:each) do
    assign(:executables, [
      stub_model(Executable),
      stub_model(Executable)
    ])
  end

  it "renders a list of executables" do
    render
  end
end
