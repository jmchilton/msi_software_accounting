require 'spec_helper'

describe "purchases/show.html.erb" do
  include ViewHelpers

  before(:each) do
    resource = FactoryGirl.build(:resource, :name => "Gaussian")
    purchase = FactoryGirl.build(:purchase, :pid => 100, :fy10 => 100, :fy11 => 200, :fy12 => 300, :fy13 => 400, :resource => resource)
    @purchase = assign(:purchase, purchase)
    render
  end

  specify { it_should_have_model_field("resource_name", "Resource", "Gaussian") }
  specify { it_should_have_model_field("os", "Operating System", "Linux")}
  specify { it_should_have_model_field("fy10", "FY 2010", "100") }
  specify { it_should_have_model_field("fy11", "FY 2011", "200") }
  specify { it_should_have_model_field("fy12", "FY 2012", "300") }
  specify { it_should_have_model_field("fy13", "FY 2013", "400") }

end
