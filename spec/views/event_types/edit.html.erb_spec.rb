require 'spec_helper'

describe "event_types/edit.html.erb" do
  before(:each) do
    @event_type = assign(:event_type, stub_model(EventType,
      :id => 1,
      :feature => "MyString",
      :vendor => "MyString"
    ))
  end

  it "renders the edit event_type form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => event_types_path(@event_type), :method => "post" do
      #assert_select "input#event_type_id", :name => "event_type[id]"
      #assert_select "input#event_type_feature", :name => "event_type[feature]"
      assert_select "input#event_type_resource_id", :name => "event_type[resource_id]"
    end
  end
end
