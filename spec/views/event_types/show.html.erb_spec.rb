require 'spec_helper'

describe "event_types/show.html.erb" do
  before(:each) do
    @event_type = assign(:event_type, stub_model(EventType,
      :id => 1,
      :feature => "Feature",
      :vendor => "Vendor"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Feature/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Vendor/)
  end
end
