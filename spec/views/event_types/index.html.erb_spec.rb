require 'spec_helper'

describe "event_types/index.html.erb" do
  before(:each) do
    assign(:event_types, [
      stub_model(EventType,
        :id => 1,
        :feature => "Feature",
        :vendor => "Vendor"
      ),
      stub_model(EventType,
        :id => 1,
        :feature => "Feature",
        :vendor => "Vendor"
      )
    ])
  end

  it "renders a list of event_types" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Feature".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Vendor".to_s, :count => 2
  end
end
