require 'spec_helper'

describe TableController do


  describe "shared fields" do

    specify { TableController.fy_10_field[:field].should == "fy10" }
    specify { TableController.fy_11_field[:label].should == "Cost (FY 2011)"}

  end

  describe "respond_with_table" do

    describe "row counts" do

      before(:each) {
        rows = mock("rows")
        rows.stub!(:count).and_return(100)
        rows.stub!(:all).and_return([1,2,3,4,5])
        controller.instance_variable_set :@fields, []
        controller.instance_variable_set :@rows, rows
      }

      it "should optimize db access when pagination is disabled by counting result array" do
        controller.instance_variable_set :@allow_pagination, false
        controller.send(:process_rows, true)
        assigns(:row_count).should == 5
      end

      it "should count the full results of relation, not just this page, when pagination is enabled" do
        controller.instance_variable_set :@allow_pagination, true
        controller.send(:process_rows, true)
        assigns(:row_count).should == 100
      end

    end
  end

  describe "render json" do

    it "should include page, rows, and total count" do
      fields = [{:field => :moo}]
      rows = mock("mock")
      rows.stub!(:to_jqgrid_json).with([:moo], 2, 100, 503).and_return("expected_json")
      controller.instance_variable_set :@fields, fields
      controller.instance_variable_set :@rows, rows
      controller.instance_variable_set :@row_count, 503
      controller.params = {:page => 2, :rows => 100}
      json = controller.send(:get_json)
      json.should == "expected_json"
    end

  end

end