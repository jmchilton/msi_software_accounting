require 'spec_helper'

describe TableController do


  describe "shared fields" do

    specify { TableController.fy_10_field[:field].should == "fy10" }
    specify { TableController.fy_11_field[:label].should == "Cost (FY 2011)"}

  end

end