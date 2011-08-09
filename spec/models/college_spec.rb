require 'spec_helper'

describe College do

  describe "reports" do

    describe "cfans report" do 
      let(:cfans_report) { College.report.first }

      it "should be sorted by resource name" do
        cfans_report.name.should eql("CFANS")
      end

      it "should use one package" do
        cfans_report.num_packages.should eql(1)
      end

      it "should contain software count" do
        cfans_report.should respond_to(:num_packages)
      end

      it "should contain total costs per year" do 
        cfans_report.should respond_to(:fy11)
      end

      it "should have 0 as 2010 cost" do
        cfans_report.fy10.should eql(10)
      end

      it "should have 20 as 2011 cost" do
        cfans_report.fy11.should eql(20) 
      end 
  
      it "should have 25 as 2012 cost" do
        cfans_report.fy12.should eql(25)
      end

      it "should have 0 as 2013 cost" do 
        cfans_report.fy13.should eql(0)
      end


    end

    describe "it report" do
      let(:it_report) { College.report.find_by_name("IT") }
  
      it "should have a cost of 10" do
        it_report.fy10.should eql(10)
      end
  
    end

    describe "pub_health report" do
      let(:cph_report) { College.report.find_by_name("CPH") }

      it "should have a cost for multiple resources" do
        cph_report.fy11.should eql(20)
      end
 
      it "should use two packages" do
        cph_report.num_packages.should eql(2)
      end

    end


  end
  
  it "should be readonly" do 
    college = FactoryGirl.create(:college)
    lambda {college.destroy}.should raise_error(ActiveRecord::ReadOnlyRecord)
  end  
  
end

