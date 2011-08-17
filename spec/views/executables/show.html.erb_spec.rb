require 'spec_helper'

describe "executables/show.html.erb" do
  before(:each) do
    @executable = assign(:executable, stub_model(Executable))
  end

  it "renders attributes in <p>" do
    render
  end
end
