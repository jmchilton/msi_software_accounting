require 'spec_helper'

describe ReportController do

  describe "report_options" do

    let(:report_options) { controller.send(:report_options) }

    describe "limit_users" do
      it "should be nil is no text" do
        controller.params[:limit_users] = ""
        report_options[:limit_users].should be_nil
      end

      it "should be list if has text" do
        controller.params[:limit_users] = " moo, cow "
        report_options[:limit_users].should eql(["moo", "cow"])
      end

    end

  end

end