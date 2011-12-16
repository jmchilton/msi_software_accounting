require 'spec_helper'

describe PlotController do
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

end