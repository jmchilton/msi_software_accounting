require 'spec_helper'

describe ApplicationController do

  describe "set_line_chart_data wit date" do
    before(:each) {
      controller.params[:from] = "2011-01-03"
      controller.params[:to] = "2011-01-06"
      controller.send(:add_line_chart_data, [[2.days.ago, 5]])
    }

    let(:chart_data) { assigns(:chart_data) }
    let(:options) { chart_data.options }

    it "should specify minimum x-axis" do
      options[:xaxis][:min].should eql((Date.parse("2011-01-03").to_time.to_i * 1000))
    end

    it "should specify maximum x-axis" do
      options[:xaxis][:max].should eql((Date.parse("2011-01-06").to_time.to_i * 1000))
    end

  end

  describe "set_line_chart_data" do
    before(:each) {
      controller.send(:add_line_chart_data, [[2.days.ago, 5]])
    }

    let(:chart_data) { assigns(:chart_data) }
    let(:options) { chart_data.options }


    it "should set @chart_data" do
      chart_data.should_not be_nil
    end

    it "should describe a line chart" do
      line_options = options[:lines]
      line_options[:show].should be_true
    end

    it "should specify x-axis as time" do
      options[:xaxis][:tickDecimals].should be_false
      options[:xaxis][:mode].should == :time
      options[:xaxis][:minTickSize].should == [1, "day"]
    end

    it "should specify whole numbers on y-axis" do
      options[:yaxis][:tickDecimals].should be_false
      options[:yaxis][:min].should == 0
    end

    it "should enable hovering effects" do
      options[:grid][:hoverable].should == true
    end

    it "no x-axis min or max specified by default" do
      options[:xaxis].should_not have_key("min")
      options[:xaxis].should_not have_key("max")
    end

  end


  describe "with_pagination_and_ordering" do
    let(:relation) {
      controller.send(:with_pagination_and_ordering, User)
    }
    let(:sorted_users) {
      relation.all
    }
    let(:alice_idx) {
      sorted_users.index(&with_username("alice"))
    }
    let(:shelly_idx) {
      sorted_users.index(&with_username("shelly"))
    }
    def with_username(username)
      lambda { |user| user.username == username }
    end

    it "should order properly, ascending by default" do
      controller.params = { :sidx => "username" }
      alice_idx.should be < shelly_idx
    end

    it "should order properly when given direction" do
      controller.params = { :sidx => "username", :sord => "DESC" }
      alice_idx.should be > shelly_idx
    end

    it "should set offset correctly" do
      controller.params = {:rows => 10, :page => 2}
      relation.to_sql.should match("OFFSET 10")
    end

    it "should set limit correctly" do
      controller.params = {:rows => 10, :page => 8}
      relation.to_sql.should match("LIMIT 10")
    end

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
