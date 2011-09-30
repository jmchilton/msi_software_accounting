require 'spec_helper'

describe "executables/show.html.erb" do
  before(:each) do
    executable = FactoryGirl.build(:executable, :exid => 100, :identifier => "the_feature", :comment => "the_vendor")
    @executable = assign(:executable, executable)
  end

  let(:page) { Capybara::Node::Simple.new(rendered) }

  def it_should_have_model_field(field, title, value)
    #rendered.should have_selector('div.model_field_label', value)
    page.find("div#model_field_#{field} > div.model_field_label").should have_content(title)
    page.find("div#model_field_#{field} > div.model_field_value").should have_content(value)
  end

  it "renders attributes in <p>" do
    render
    it_should_have_model_field("identifier", "Feature", "the_feature")
    it_should_have_model_field("comment", "Vendor", "the_vendor")
  end
end
